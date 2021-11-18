unit UModulos;

interface

uses
  System.SysUtils, System.Classes, Data.DB, IBX.IBDatabase, IBX.IBCustomDataSet,
  IBX.IBQuery,Winapi.Windows,Variants,FireDAC.Comp.Client;
 type
  TWebModulos = class(TIBDataSet)
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure PreparaQueryModulos;
  end;
  TABwebModulo = class(TFDMemTable)
  constructor Create(AOwner: TComponent); override;
    private
    public
  end;

implementation

uses UDataCclConfig;
{ TWebModulos }

constructor TWebModulos.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Database := VCLDM_Config.IBDB;
end;
constructor TABwebModulo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  // table field definition
  FieldDefs.Add('MODCODIGO', ftString, 3);
  FieldDefs.Add('MODNOME', ftString, 60);
  FieldDefs.Add('MODINCLUSAO', ftString,1);
  FieldDefs.Add('MODEXCLUSAO', ftString,1);
  FieldDefs.Add('MODCONSULTA', ftString,1);
  FieldDefs.Add('MODALTERACAO', ftString,1);
  FieldDefs.Add('MODIMPRESSAO', ftString,1);
  FieldDefs.Add('MODEXECUCAO', ftString,1);
  FieldDefs.Add('MODLIBERACAO', ftString,1);
  CreateDataSet;
end;

procedure TWebModulos.PreparaQueryModulos;
begin
  // Monta a query de Consulta
  SelectSQL.Clear;
  SelectSQL.Add('SELECT *            ');
  SelectSQL.Add('FROM T_MODULOS       ');
  SelectSQL.Add('ORDER BY MODNOME  ');

  // Monta a query de Refresh
  RefreshSQL.Clear;
  RefreshSQL.Add('SELECT *                       ');
  RefreshSQL.Add('FROM T_MODULOS                  ');
  RefreshSQL.Add('WHERE                          ');
  RefreshSQL.Add('   MODCODIGO  = :OLD_MODCODIGO ');
  RefreshSQL.Add('ORDER BY MODCODIGO             ');

  // Monta a query de Insert
  InsertSQL.Clear;
  InsertSQL.Add('INSERT INTO                                                  ');
  InsertSQL.Add('T_MODULOS                                                     ');
  InsertSQL.Add(' ( MODCODIGO,  MODNOME,   MODINCLUSAO, MODEXCLUSAO,          ');
  InsertSQL.Add('   MODCONSULTA, MODALTERACAO, MODIMPRESSAO, MODEXECUCAO,     ');
  InsertSQL.Add('   MODLIBERACAO )                                            ');
  InsertSQL.Add('VALUES                                                       ');
  InsertSQL.Add(' ( :MODCODIGO,  :MODNOME,   :MODINCLUSAO, :MODEXCLUSAO,      ');
  InsertSQL.Add('   :MODCONSULTA, :MODALTERACAO, :MODIMPRESSAO, :MODEXECUCAO, ');
  InsertSQL.Add('   :MODLIBERACAO )                                           ');

  // Monta a query de modify
  ModifySQL.Clear;
  ModifySQL.Add('UPDATE T_MODULOS                      ');
  ModifySQL.Add('SET                                  ');
  ModifySQL.Add('   MODNOME      = :MODNOME,          ');
  ModifySQL.Add('   MODINCLUSAO  = :MODINCLUSAO,      ');
  ModifySQL.Add('   MODEXCLUSAO  = :MODEXCLUSAO,      ');
  ModifySQL.Add('   MODCONSULTA  = :MODCONSULTA,      ');
  ModifySQL.Add('   MODALTERACAO = :MODALTERACAO,     ');
  ModifySQL.Add('   MODIMPRESSAO = :MODIMPRESSAO,     ');
  ModifySQL.Add('   MODEXECUCAO  = :MODEXECUCAO,      ');
  ModifySQL.Add('   MODLIBERACAO = :MODLIBERACAO      ');
  ModifySQL.Add('WHERE                                ');
  ModifySQL.Add('   MODCODIGO    = :OLD_MODCODIGO     ');

  // Monta a query de Delete
  DeleteSQL.Clear;
  DeleteSQL.Add('DELETE                               ');
  DeleteSQL.Add('FROM T_MODULOS                        ');
  DeleteSQL.Add('WHERE                                ');
  DeleteSQL.Add('   MODCODIGO    = :MODCODIGO         ');
end;

end.
