unit UAcessos;

interface

uses
  System.SysUtils, System.Classes, Data.DB, IBX.IBDatabase, IBX.IBCustomDataSet,
  IBX.IBQuery,Winapi.Windows,Variants;
 type
  TWebAcessos = class(TIBDataSet)

    private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure PreparaQueryAcessos;
  end;

implementation

uses UDataCclConfig;
{ TWebAcessos }

constructor TWebAcessos.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Database := VCLDM_Config.IBDB;
end;


procedure TWebAcessos.PreparaQueryAcessos;
begin
  // Monta a query de Consulta
  SelectSQL.Clear;
  SelectSQL.Add('SELECT *                        ');
  SelectSQL.Add('FROM T_ACESSOS                   ');
  SelectSQL.Add('ORDER BY ACSUSUARIO, ACSMODULO  ');

  // Monta a query de Refresh
  RefreshSQL.Clear;
  RefreshSQL.Add('SELECT *                             ');
  RefreshSQL.Add('FROM T_ACESSOS                        ');
  RefreshSQL.Add('WHERE                                ');
  RefreshSQL.Add('   ACSUSUARIO  = :OLD_ACSUSUARIO AND ');
  RefreshSQL.Add('   ACSMODULO   = :OLD_ACSMODULO      ');
  RefreshSQL.Add('ORDER BY ACSUSUARIO, ACSMODULO       ');

  // Monta a query de Insert
  InsertSQL.Clear;
  InsertSQL.Add('INSERT INTO                                                  ');
  InsertSQL.Add('T_ACESSOS                                                     ');
  InsertSQL.Add(' ( ACSUSUARIO, ACSSENHA, ACSMODULO, ACSPERMISS ) ');
  InsertSQL.Add('VALUES                                                       ');
  InsertSQL.Add(' ( :ACSUSUARIO, :ACSSENHA, :ACSMODULO, :ACSPERMISS ) ');

  // Monta a query de modify
  ModifySQL.Clear;
  ModifySQL.Add('UPDATE T_ACESSOS                      ');
  ModifySQL.Add('SET                                  ');
  ModifySQL.Add('   ACSPERMISS   = :ACSPERMISS        ');
  ModifySQL.Add('WHERE                                ');
  ModifySQL.Add('   ACSUSUARIO   = :OLD_ACSUSUARIO AND');
  ModifySQL.Add('   ACSMODULO    = :OLD_ACSMODULO     ');

  // Monta a query de Delete
  DeleteSQL.Clear;
  DeleteSQL.Add('DELETE                               ');
  DeleteSQL.Add('FROM T_ACESSOS                        ');
  DeleteSQL.Add('WHERE                                ');
  DeleteSQL.Add('   ACSUSUARIO   = :OLD_ACSUSUARIO AND');
  DeleteSQL.Add('   ACSMODULO    = :OLD_ACSMODULO     ');
end;

end.
