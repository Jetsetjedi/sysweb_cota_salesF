unit UDataCadastro;

interface

uses
  System.SysUtils, System.Classes, Data.DB, IBX.IBCustomDataSet, IBX.IBQuery;

type
  TDM_Cadastro = class(TDataModule)
    IB_Usuario: TIBDataSet;
    DS_Usuario: TDataSource;
    IB_UsuarioTUSCOD: TIBStringField;
    IB_UsuarioTUSSENHA: TIBStringField;
    IB_UsuarioTUSLOGIN: TIBStringField;
    IB_UsuarioTUSNOME: TIBStringField;
    IB_UsuarioTUSATIVO: TIntegerField;
    IB_UsuarioTUSFUNCAO: TIBStringField;
    IB_UsuarioTUSADM: TIBStringField;
    IB_UsuarioTUSEMAIL: TIBStringField;
    IB_UsuarioTUSSENHAEMAIL: TIBStringField;
    IB_UsuarioTUSLOGADO: TSmallintField;
    IB_UsuarioTUSAUDITOR: TSmallintField;
    IB_UsuarioTUSDEPTO: TIBStringField;
    IB_UsuarioTUSVENDA: TIntegerField;
    IB_UsuarioTUSEQUIPE: TIntegerField;
    IB_UsuarioTUSAPROVA_ASI: TIntegerField;
    IB_UsuarioTUSUPERVISORASSTEC: TIntegerField;
    IB_UsuarioTUSAUTENTICAGUIA: TIntegerField;
    IB_UsuarioTUSLOGINRFWINDOWS: TIBStringField;
    IB_UsuarioTUALERTAFINANCEIRO: TSmallintField;
    IB_UsuarioTUALERTADESENVOLVIMENTO: TIntegerField;
    IB_UsuarioTUSVERMETAS: TSmallintField;
    IB_UsuarioTUPRODUCAO: TSmallintField;
    IB_UsuarioTUSPRODTOTAL: TSmallintField;
    IB_UsuarioTUSPRODPRIOR: TSmallintField;
    IB_UsuarioTUSPRODMMP: TSmallintField;
    IB_UsuarioTUSPRODIMPRL: TSmallintField;
    IB_UsuarioTUSPRODMONT: TSmallintField;
    IB_UsuarioTUSPRODIMPCX: TSmallintField;
    IB_UsuarioTUSPRODRETOMAR: TSmallintField;
    IB_UsuarioTUSPRODIMPREL: TSmallintField;
    IB_UsuarioTUSPRODPARCIAL: TSmallintField;
    IB_UsuarioTUSPRODTROCAMQ: TSmallintField;
    IB_UsuarioTUSPRODPARADA: TSmallintField;
    IB_UsuarioTUSPRODCONSULTA: TSmallintField;
    IB_UsuarioTUSPRODBLOQ: TSmallintField;
    IB_UsuarioTUSLIBOFETQ: TSmallintField;
    DS_Modulos: TDataSource;
    IB_Modulos: TIBDataSet;
    IB_ModulosMODCODIGO: TIBStringField;
    IB_ModulosMODNOME: TIBStringField;
    IB_ModulosMODINCLUSAO: TIBStringField;
    IB_ModulosMODEXCLUSAO: TIBStringField;
    IB_ModulosMODCONSULTA: TIBStringField;
    IB_ModulosMODALTERACAO: TIBStringField;
    IB_ModulosMODIMPRESSAO: TIBStringField;
    IB_ModulosMODEXECUCAO: TIBStringField;
    IB_ModulosMODLIBERACAO: TIBStringField;
    DS_Acessos: TDataSource;
    IB_Acessos: TIBDataSet;
    IB_AcessosACSUSUARIO: TIBStringField;
    IB_AcessosACSSENHA: TIBStringField;
    IB_AcessosACSMODULO: TIBStringField;
    IB_AcessosACSPERMISS: TIBStringField;
    IB_Pesquisa: TIBQuery;
    DS_Pesquisa: TDataSource;
    IB_Consulta: TIBQuery;
    DS_Consulta: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM_Cadastro: TDM_Cadastro;

implementation

uses UDataConfig;

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

end.
