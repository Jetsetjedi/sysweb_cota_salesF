unit UDataCclConfig;

interface

uses
  System.SysUtils, System.Classes, Data.DB, IBX.IBCustomDataSet, IBX.IBQuery,
  IBX.IBDatabase, Datasnap.DBClient, SimpleDS, Datasnap.Provider;
  const
  Beta       = ' ß08.04'; // MES.SEQUENCIAL
  AnoVersao  = ' 2021';
//  Beta       = '';

//  SiglaTela  = 'Syslog';
//  Software   = 'Syslog 2015 ' + Beta;
//  Version    = '2015 ' + Beta;
//  SystemName = 'Sistema Syscontrol';
//  Copyright  = '©1997-2016 Syscontrol Automação por Código de Barras';
//  UserName   = 'Syscontrol Automação por Código de Barras';
//  License    = 'Syscontrol Automação Industrial Ltda';
  ArqConfig  = 'SYSLOGCFG.INI';
  ArqReceber = 'BCORECEBER.INI';
  numeroserienotafiscal = '2';
  numeroserienfe        = '1';
  numeroserienfse       = 'S';
  senhaProtecao         = '03167087';
  senhaLp               = '01105147';
  StatusLiberado  = 'Liberado';
  StatusReservado = 'Reservado';
  StatusBloqueado = 'Bloqueado';
  StatusResPend   = 'Res. Pend.';
  StatusLibPend   = 'Bloq. Pend.';
  StatusProvisionado = 'Provisionado';

type
  TVCLDM_Config = class(TDataModule)
    IBDB: TIBDatabase;
    IBTransaction: TIBTransaction;
    Q_Update: TIBQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure AtualizaASCII;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  VCLDM_Config: TVCLDM_Config;

  // Variaveis de processo do Syslog no windows
  MPidExecutavel: Cardinal;
  //MHandle: HWND;

  //////   STRING    ///////////////////////////////////////////////////////////

  // Variável Global para Definicao do Estado de Calculo para Impostos
  SiglaTela,
  Software,
  Version,
  SystemName,
  Copyright,
  UserName,
  License,
  NomeEmpresa,
  DescrEmpresa,
  EnderEmpresa,
  FoneEmpresa,
  CNPJEmpresa,
  IEEmpresa,
  LogoColor,
  LogoPB,
  EmailAviso,
  URL_RJ,
  URL_ES,
  URL_Demais,
  UFWork,
  IPWindows,
  NomeWindows,
  IPLinux,
  NomeLinux
      : string;

  {+h$} MotivoAjuste,
        NaturezaAjuste : string; {-h$}

  DataCusto,
  ComandoSQL,
  NumeroRMA,
  NumeroRMAOS,
  _codigoos,
  _codigomov,
  ChaveBusca,
  ChaveFind,
  Tipo_Empresa,
  DescricaoServico: string;

  larguraFrm027,
  alturaFrm027,
  profundidadeFrm027,
  pesoFrm027,
  MsgRetorno,
  OFCotacao,
  OFSel259 : string;
  CotacaoTransp : Boolean;

  TipoMoeda : string;

  Str_Valor_UnitHard,
  Str_Valor_TotHard,
  Str_Valor_IPI,
  Str_Valor_UnitServ,
  Str_Valor_TotServ,
  Str_Valor_ISS,
  Str_Valor_IR,
  Str_Valor_ICMS_Sub,
  Str_Valor_Base_ICMS_Sub,
  Str_Total_ICMS_Sub,
  // Samuca - 30/06/2010 - Comissao ------
  Str_Valor_PIS,
  Str_Valor_COFINS,
  Str_Valor_COMISSAO,
  Str_Valor_ICMS,
  // -------------------------------------
  Arquivo,
  MLinha,
  CodProdForn,
  descprod,
  codtrab,
  nota,
  serie,
  Merge_descprod,
  Merge_codtrab,
  Merge_nota,
  Merge_serie,
  Merge_Quantidade,
  Merge_linha1,
  Merge_Linha2,
  MErge_linha3,

  Merge2_descprod,
  Merge2_codtrab,
  Merge2_nota,
  Merge2_serie,
  Merge2_Quantidade,
  Merge2_linha1,
  Merge2_Linha2,
  MErge2_linha3,
  Merge_CxsQuantidade,
  Merge_NumeroLote,

  _RetornoPesquisa,

  TipoAjuste,

// Variavel de diferenciacao de Produto e Ativo
  Tabela_Produto,
  Tabela_Cliente,
  Tabela_NSerie,
  Tabela_Contatos,
  Tabela_Hist_Acompanhamentos,
  // Variaval para Opcao do Menu
  EstadoGNRE,
  CodOrcto,
  DiaSel,
  MesSel,
  AnoSel,
  CodProduto,
  CodigoEntidade,
  AntOrcamento,
  CodOrcamento,
  CodOrdemFatura,
  DataDolar,
  ValorDolar,
  ValorEuro,
  vFamilia,
  vFornecedor,
  ccodigo,
  CodigoUsuario,
  NomeUsuario,
  LoginUsuario,
  Setor,
  EmailSyscon,
  EmailSpool,
  Old_CodigoUsuario,
  Old_NomeUsuario,
  Old_LoginUsuario,
  Old_Setor,
  Old_EmailSyscon,
  CodigoGuardado,
  NomeGuardado,
  CodigoVendedor,
  VendedorGuardado,
  ModuloAcesso,
  PRINTSaida,
  PRINTSetup,
  ArqBancoTrabalho,
  ArqBancoBackup,
  ServidorBanco,
  UsuarioBanco,
  SenhaBanco,
  StartPath,
  OFEletronica,
  NomeOperador,
  F018F_NumeroOF  : string;
  //////////////////////////////////////////////////////////////////////////////


  //////   BOOLEAN  ////////////////////////////////////////////////////////////
  F018F_CancelaConferencia,
  ConferenciaAutomatica,
  Old_FiltraEquipe,
  SistemaJaIniciado : boolean;

  AjusteManual,
  TemGNRE,
  OkCriado,
  OkInicio,
  OkInclusao,
  OkExclusao,
  OkAlteracao,
  OkConsulta,
  OkImpressao,
  OkExecucao,
  OkLiberacao,
  OkModulo,
  OkConciliaNum,
  selectcombo,
  IsCancel,
  FiltraEquipe,
// Variavel para Cadastro de Comissoes
  iseditingX,
  isaddingX,
// Variavel para Instrucao do Comercial
  PrintInstrucao,
// Variavel para Cadastro de Planta/Contato
  iseditingC,
  isaddingC,
  isselectedC,
// Variavel para Cadastros em Geral
  IsSelected,
  IsSelectedItem,
  isgarantia,
  IsCadastro,
  IsSearching,
  IsPrinter,
  IsCombo,
  IsInitial,
  IsSelect,
  IsAdding,
  IsEditing,
  IsEditingL,
  executandomenu,
  iscondcom,
  IsMontagem,
  isaddingOS,
  IsSerial,
  EhImportacao,
  EhFilial : boolean;
  //////////////////////////////////////////////////////////////////////////////


  //////   REAL  ///////////////////////////////////////////////////////////////

  TaxaDolar,
  TaxaEuro,
  _Afrmm,
  _Siscomex : real;

  // Calculo de Valores do Produto
  Valor_ProdutoHard,
  Valor_UnitarioServ, Valor_TotalServ,
  Valor_UnitarioHard, Valor_TotalHard,
  Valor_ProdutoServ,  Valor_IPI_Sub,  Valor_Base_ICMS_Sub,
  Valor_ICMS_Sub,     Valor_ICMS,

  // Samuca - 30/06/2010 - Comissao --------------
  Valor_IPI, Valor_ISS, Valor_IR,
  Valor_PIS, Valor_COFINS, Valor_COMISSAO,
  Valor_ComissaoSW, Valor_ComissaoHW,
  Valor_Base_ComissaoSW, Valor_Base_ComissaoHW,
  Aliq_ICMS, Aliq_PIS, Aliq_COFINS, Aliq_COMISSAO,
  Valor_Base_ICMS, Valor_Base_IPI,
  // Samuca - 29/06/2011 - Comissão Representanta ----------------------------
  Repr_Produto,
  Repr_ProdutoHard,
  Repr_UnitarioServ, Repr_TotalServ,
  Repr_UnitarioHard, Repr_TotalHard,
  Repr_ProdutoServ,  Repr_IPI_Sub,  Repr_Base_ICMS_Sub,
  Repr_ICMS_Sub,     Repr_ICMS,
  Repr_IPI, Repr_ISS, Repr_IR,
  Repr_PIS, Repr_COFINS, Repr_COMISSAO,
  Repr_ComissaoSW, Repr_ComissaoHW,
  Repr_Base_ComissaoSW, Repr_Base_ComissaoHW,
  Quantidade,
  Aliq_IPI, Aliq_ISS, Aliq_IR,
  Aliq_Representante,
  Cento_HARD, Cento_SERV, Cento_Subst,
  XHard, YSERV, Valor_Produto                                : real;
  //////////////////////////////////////////////////////////////////////////////

  // SAMUCA - 30/09/16 - Inclusão CNAE
  ServValorTudo, ServValorIR,
  Valor_ServISS, Valor_ServPIS, Valor_ServCOFINS, Valor_ServCSLL, Valor_ServIR : REAL;
  Aliq_ServISS, Aliq_ServPIS, Aliq_ServCOFINS, Aliq_ServCSLL, Aliq_ServIR : REAL;
  ServDestacaTudo, ServDestacaIR : boolean;



  //////   INTEGER  ////////////////////////////////////////////////////////////
  sequencia,
  ContaProduto,
  ContaServico,
  CodPlanta,
  CodigoPlanta,
  PRINTDevice,
  PRINTFlow: Integer;
  VarTotalOfsHoje,
  VarTotalOFsAmanha,
  VarTotalOFDoisDias,
  VarTotalOFsProximos : Integer;
  //////////////////////////////////////////////////////////////////////////////

  //////   DATE TIME  //////////////////////////////////////////////////////////
  DataSelecionada: TDateTime;
  //////////////////////////////////////////////////////////////////////////////

  Etiqueta: array of array of string;

  OpcaoMenu : string[5];

  Merge_NumeroSerie, Merge_CodSistema, Merge_DescKit, Merge_DescKit1, Merge_DescKit2: string;
  Merge2_NumeroSerie, Merge2_CodSistema, Merge2_DescKit, Merge2_DescKit1, Merge2_DescKit2: string;

  //variaveis das etiquetas de caixa de separação
  etqcodclient: string[12];
  etqplantaclient: string[3];
  etqendent: string[40];
  etqnument: string[6];
  etqcomplent: string[15];
  etqbairroent: string[20];
  etqcidadeent: string[40];
  etqufent: string[20];
  etqcepent: string[10];
  etqclrazao: string[60];
  etqtransportadora: string[40];
  etqcxof: string[9];
  etqcxnum: string[4];
  etqcxpesoliq: string[6];
  etqcxpesobruto: string[6];
  etqcxnotasaida: string[6];
  etqcxitens: string[3];
  etqcxprod: string[58];
  etqcxfinal: string[4];
  etqcxprodquantidade: string[3];
  etqcxslogo: string;
  imagem: array[1..2] of string[128];

//    Merge_NumeroSerie,Merge_CodSistema,Merge_DescKit:String;
  prnzpl, prnimg, prnporta, prnvelocidade, prnbitdados, prnparidade, prnbitparada, prnfluxo: string;
  prnplataforma, prnzpl2, prnimg2: string;
  oksend: boolean;
  linhamemo:integer;

//----------------------------------------------------------------------------\\
// Variáveis globais utilizadas para receber o calculo da NF da Unit UCalculo.pas
// Francisco 26/11/2003
    vtProduto,
    vtIPI,
    vtBaseCalculo,
    vtBaseReducao,
    vtBaseNota,
    vtBaseCalculoSubst,
    vtServicoarredonda,
    vtServico,
    vtICMSarredonda,
    vtICMS,
    vtISS,
    vtIR,
    vtServISS,
    vtServIR,
    vtServPIS,
    vtServCOFINS,
    vtServCSLL,
    // Samuca = 30/06/2010 - Comissao ---------
    vtPIS,
    vtCOFINS,
    vtCOMISSAO,
    // ----------------------------------------
    vtDifalDestino,
    vtFecpDestino,
    vtGnreDestino,
    vtDifalOrigem,
    vtBaseSubst,
    vtSubstituicao,
    vtOutrasDespesas,
    vtNF: Real;
//----------------------------------------------------------------------------\\

  _COD_INVENTARIO,
  OrdemCompra,
  _NOF : String;

//  vprodutoCalculo: array of TProdutoCalculo;
//  NumeroSerie : array of TNumeroSerie;
//
//  VContaPagar : array of TContaPagar;
//  VContas : array of TContas;
//  VContasAntecipado : array of TContas;
//
//  Vbaixa : array of TContas;
//  PagamentoParcial : TPagamentoParcial;
//  dadosContrato : TContrato;

// Variáveis Globais de Boleto (Form043) - Luís Marcelo 05/03/2009
   blDataemissao: string[10];
   blValormora: real;
   blLinhaDigitavel: string[54];
   blCodBarras: string[44];
   blNossoNumero: string[16];
   blreimpressao: boolean;

//-Variáveis para consulta de contatos -----------------------------------------
   consulta_contato,
   consulta_codigo : String;
   consulta_planta : integer;
   okagenda : boolean;

//----------------------------------------------------------------------------\\
   _ALERTADEMO : integer;

//----------------------------------------------------------------------------\\
  numeroserienfemissao: string;

  //_RETORNODEMO : boolean;

  cidadeibge: string;
  estadoibge: string;

  porcentagemjurosmes: real;
//------------------------------------------------------------------------------
//      POSIÇÃO DO ESTOQUE

  _TotalEstoque,
  _Usados,
  _reqint,

  _RMAExterno,
  _Reservados,
  _Bloqueados,
  _Disponivel,
  _EmprestimoRMA,
  _Expedidos,
  _Recebidos,
  _DEMO,
  _LOCACAO,
  _REQUISITADOS,
  _TRANSFORMACAO,
  _Faturados,
  _ASSTEC : integer;

//------------------------------------------------------------------------------

  alteracaoform: boolean;
  tipolancamentocp: integer;
  _GARANTIA_ASSTEC : integer;

  tipotransportadora : string[1];

  numeroosetq: string[9];
  etqOSreimpressao: integer;
  etqOSnumeronf: string;
  etqOSserienf: string;
  etqOSqtdeacessorios: integer;
  etqOSnumacessorio: integer;
  etqOStotalacessorios: integer;
  etqOSacessorio, etqOSAcessorio2: string;

  _GARANTIA_ASSTEC_TIPO : string;

  _COD_CLIENTE : String;
  _PLANTA_CLIENTE : integer;
  _RAZAO_CLIENTE: String;
  _CNPJ_CLIENTE: string;
  //Vconciliacao : array of TConciliacaoBancaria;
  _CANCELACONCILIACAO : boolean;

  _BTNCANCEL : boolean;

  _ALERTACI : boolean;

  _Data1,
  _Data2 : TDateTime;
  AjusteOF,
  EtiquetaOF,
  ConsultaOF,
  Mostra040,
  EhCliente,
  AjusteEstoque : boolean;
  senhaSYSDBA: string;

  _planejamentodiario: boolean;
  _pendencias : boolean;

  ultimoeuro: real;

  NovoAtendimento : boolean;
  MovAtendimento  : string;

  enviar: boolean;

  CodLancamentoCR: string;

  TemDifal,
  TemDifalPartilha: boolean;
  // Samuca - 31/03/2016 - DIFAL ----------------
  Valor_Difal, Valor_Fecp, Valor_Partilha_Origem, Valor_Partilha_Destino,
  Perc_Difal, Perc_Partilha_Origem, Perc_Partilha_Destino, Valor_GNRE, Aliq_ICMS_Destino,
  Aliq_FECP_Destino, PartilhaOrigem, PartilhaDestino : real;
  // --------------------------------------------
  // Samuca - 31/03/2016 - DIFAL ---------
  Str_Valor_Base_ICMS,
  Str_Aliq_ICMS_Destino,
  Str_Valor_Difal,
  Str_Valor_Fecp,
  Str_Valor_Partilha_Origem,
  Str_Valor_Partilha_Destino,
  Str_Valor_GNRE: string;
  // -------------------------------------

  numreqinterna: string;
  reqint: integer;

  chavenfereferenciada: string;

  F199A_TipoLocalizacao : integer;
  F199A_TextoBusca : string;
  F199A_TemPesquisa,
  F199A_Negociacao,
  F199A_Ativo,
  F199A_Cancelado,
  F199A_Encerrado,
  F199A_Aguardando,
  F199A_Reprovado,
  F199A_Aprovado : boolean;

  testereducao: real;

  MargemRepresentante: real;

  destacafrete: boolean;
  valordestaquefrete: real;

  retornobusca, retornobusca2: string;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}
uses UTools_CLX, Server.Forms.Main;

procedure TVCLDM_Config.DataModuleCreate(Sender: TObject);
begin
// Faz a atribuição dos valores padrões para as variáveis
  // Verifica o diretório de inicialização do sistema
  StartPath := ExtractFilePath(ParamStr(0));
  if StartPath[Length(StartPath)] <> '\' then
    StartPath := StartPath + '\';

//  ArqBancoTrabalho := 'SYSLOGDB.GDB';
//  ArqBancoBackup := 'SYSLOGDB.GDK';
//  ServidorBanco := '192.168.0.1';
  UsuarioBanco := 'sysdba';
  UFWork := '';
  UFWork := '';
  UFWork := Copy(verificaini(StartPath+ArqConfig, 'Unidade',    'Estado',            'SP - SÃO PAULO',           'LER'), 1, 2);
  if AllTrim(UFWork) = '' then
    UFWork := 'SP';

  if alltrim(UFWork) = 'SP' then
     senhaSYSDBA :='masterkey' //'6hYbcKWE'
  else
     senhaSYSDBA := 'DJd20FfO';
  SenhaBanco := senhaSYSDBA;
//Para desenvolvimento indica o local da base no main form
 ServidorBanco :=ALLTRIM(verificaini(StartPath+ArqConfig, 'Interbase',  'ServidorBanco', ServidorBanco,              'LER'));
 ArqBancoTrabalho:=ALLTRIM(verificaini(StartPath+ArqConfig, 'Interbase',  'BancoTrabalho', StartPath+ArqBancoTrabalho, 'LER'));

      VCLDM_Config.IBDB.Connected := false;
      VCLDM_Config.IBDB.Params.Clear;
      VCLDM_Config.IBDB.DatabaseName :=ServidorBanco+':'+ArqBancoTrabalho;
      VCLDM_Config.IBDB.Params.Values['user_name'] := UsuarioBanco;
      VCLDM_Config.IBDB.Params.Values['password'] := SenhaBanco;
      VCLDM_Config.IBDB.Params.Values['lc_ctype']:= 'utf-8';
      Try
       //AtualizaASCII;
       VCLDM_Config.IBDB.Connected := true;

      Except
      on E: Exception do
        begin
          MainForm.mlogserver.Lines.Add('IBDB: ' + E.Message );
         Exit;
        end;
      end;
end;
  procedure TVCLDM_Config.AtualizaASCII;
  var
   ascfile:TStringList;
   lin:Integer;
  begin
//     CDasciiext.Active:=False;
//     ascfile:=TStringList.Create;
//     ascfile.LoadFromFile('asciiext.crt');
//     ascfile.DelimitedText:='|';
//      CDasciiext.CreateDataSet;
//      CDasciiext.Open;
//      CDasciiext.Insert;
//     for lin := 0 to ascfile.Count do
//       begin
//          CDasciiextcaracter.AsString:=ascfile[lin];
//       end;
  end;

end.
