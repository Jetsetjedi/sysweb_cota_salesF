unit UDataConfig;

interface

uses
  System.SysUtils, System.Classes, Data.DB, IBX.IBDatabase, IBX.IBCustomDataSet,
  IBX.IBQuery,Winapi.Windows;

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
    TQuantidade = record
       tq_data : TDateTime;
       tq_codsys : String;
       tq_nserie : String;
       tq_nota : String;
       tq_serie : String;
       tq_oc : String;
       tq_qtd : Integer;
       tq_endereco : String;
    end;

    TPagamentos = record
        INVOICE : String;
        CODFOR : String;
        PLANTA : Integer;
        DATA_PAGAMENTO : TDateTime;
        VALOR : Real;
        LOGIN : String;
        CODUSR: String;
        CONTRATO: string;
        MOEDA: string;
        VALORDOLAR: real;
    end;

    TContaPagar = record
        ID      : String;
        MERCADO : integer;
        CONDPAGTO : integer;
        DATA : TDateTime;
        VENCIMENTO : TDateTime;
        PAGAMENTO : TDateTime;
        VALORDOC : Real;
        VALORPAGO : Real;
        VALORPENDENTES : Real;
        NUMEMERO_DOC : String;
        DESCRICAO : String;
        STATUS : Integer;
        BAIXA : String;
        PAGTO : String;
        DESCONTO : Real;
        MULTA : Real;
        DOLAR_ENTRADA : Real;
        DOLAR_FECHAMENTO : Real;
        CONTRATO_CAMBIO : String;
        AWB : String;
        INVOICE : String;
        DI : String;
        NF : String;
        TIPO_CENTROCUSTO :  String;
        CODFORNECEDOR : String;
        PLANTAFORNECEDOR : Integer;
        SELECIONADO : boolean;
    end;

    TContrato = record
       id              : String;
       contrato        : String;
       dolar           : Real;
       valor           : Real;
       valorPago       : Real;
       valorPagoBR     : Real;
       banco           : String;
       valorContrato   : Real;
       dolarTurismo    : Real;
       valorContratoBR : Real;
    end;

    TPagamentoParcial = record
      VALOR_DEVIDO          : Real;
      VALOR_PAGAR           : Real;
      SALDO                 : Real;
    end;

    TContas = record
      TCPI_COD              : String;
      TCPI_DI               : String;
      TCPI_INVOICE          : String;
      TCPI_DATA_INVOICE     : TDateTime;
      TCPI_FORNECEDOR       : String;
      TCPI_CODFOR           : String;
      TCPI_PLATAFOR         : integer;
      TCPI_DATA_AWB         : TDateTime;
      TCPI_AWB              : String;
      TCPI_COND_PAGTO       : String;
      TCPI_VENCIMENTO       : TDateTime;
      TCPI_VALOR_DOCUMENTO  : Real;
      TCPI_VALOR_PENDENTE   : Real;
      TCPI_STATUS           : integer;
      CHECK                 : boolean;
    end;

  TNumeroSerie = record
    codsys : String;
    produto : String;
    nserie : String;
    qtd : String;
    nof : String;
  end;

  TprodutoCalculo = record
    aCodof: string;
    aProdCod: string;
    aUnitProduto : Real;
    aPorcProduto: Real;
    aPorcServico: Real;
    aqtd: Real;
    aAliqIPI: Real;
    aAliqIcms: Real;
    aAliqiss: Real;
    aAliqir: Real;
    aAliqSubst: Real;     // Samuca - 10/07/09 - Substituicao Tributaria
    aAliqReducao: Real;   // Samuca - 28/07/11 - Redução Base do ICMS
    amoeda: string;
    adolar: Real;
    atipo : integer; //  tipo de calculo(0-normal / 1 venda para revenda)
    aProdvalunithard: Real;
    aProdvaltothard: real;
    aValIPI: real;
    aProdvalunitserv: real;
    aProdvaltotserv: real;
    aValiss: real;
    aValir: real;
    aValorICMS: real;
    aBaseICMS: real;          // LM - 24/08/2009 - Base de calculo ICMS do produto - NF-e
    aValorBaseSubst: real;    // Samuca - 10/07/09 - Substituicao Tributaria - NF-e
    aValorSubst: real;        // Samuca - 10/07/09 - Substituicao Tributaria
    aUnitBaseSubst: real;     // Samuca - 19/08/09 - Substituicao Tributaria - NF-e
    aUnitICMSSubst: real;     // Samuca - 19/08/09 - Substituicao Tributaria
    aDescricao: string; // LM - 29/04/2010 - Nota Serviço asstec
    aNumeroOS: string; // LM - 29/04/2010 - Nota Serviço/Produto asstec
    aValorPIS: real;
    aAliqPIS: real;
    aValorCOFINS: real;
    aAliqCOFINS: real;
    aDespesasAcessorias: real;
    aAliqICMSDestino: real;  // Samuca - 22/03/2016 - Calculo da DIFAL - Alíquota Interna Destino
    aAliqFECPDestino: real;  // Samuca - 31/03/2016 - Calculo da DIFAL - Alíquota FECP
    aAliqCnaeIR: real;      // Samuca - 30/09/16 - Inclusão CNAE Serviço
    aAliqCnaeISS: real;     // Samuca - 30/09/16 - Inclusão CNAE Serviço
    aAliqCnaePIS: real;     // Samuca - 30/09/16 - Inclusão CNAE Serviço
    aAliqCnaeCOFINS: real;  // Samuca - 30/09/16 - Inclusão CNAE Serviço
    aAliqCnaeCSLL: real;    // Samuca - 30/09/16 - Inclusão CNAE Serviço
    aValorCnaeIR: real;      // Samuca - 30/09/16 - Inclusão CNAE Serviço
    aValorCnaeISS: real;     // Samuca - 30/09/16 - Inclusão CNAE Serviço
    aValorCnaePIS: real;     // Samuca - 30/09/16 - Inclusão CNAE Serviço
    aValorCnaeCOFINS: real;  // Samuca - 30/09/16 - Inclusão CNAE Serviço
    aValorCnaeCSLL: real;    // Samuca - 30/09/16 - Inclusão CNAE Serviço
    aValorFrete: real;
  end;

 TLivroProducao = record
       TLP_ID              : String;
       TLP_PRODUTO         : String;
       TLP_HISTORICO       : String;
       TLP_NF              : String;
       TLP_NFSERIE         : String;
       TLP_DATA            : TDateTime;
       TLP_NOTA            : String;
       TLP_INVOICE         : String;
       TLP_DI              : String;
       TLP_TIPO            : String;
       TLP_QTD_ENTRADA     : Integer;
       TLP_QTD_SAIDA       : Integer;
       TLP_VALOR_TOTAL     : Real;
       TLP_QTD_ESTOQUE     : Integer;
       TLP_CM              : Real;
       TLP_VALOR_ESTOQUE   : Real;
       TLP_NATUREZA        : String;
       TLP_QTDFISCAL       : Integer;
    end;

    TConciliacaoBancaria = record
       NF : String;
       FATURA : String;
       DESCONTO : integer; //=> DESCONTO
       VALDESC  : String;
       TIPODESC : String;
       OBSDESC : String;
       PAGAMENTO : integer; //=> FATURA
       VALPAG : String;
       TIPOPAG : String;
       OBSFAT : String;
       JUROS  : integer;  //=> JUROS
       VALJUROS : String;
       TIPOJUROS : String;
       OBSJUROS : String;
       CSLL: real;
       PIS: real;
       COFINS: real;
       ISS: real;
       INSS: real;
       IR: real;
       CSLLRecolhido: string[1];
       PISRecolhido: string[1];
       COFINSRecolhido: string[1];
       ISSRecolhido: string[1];
       INSSRecolhido: string[1];
       IRRecolhido: string[1];
       OBSCSLL: string;
       OBSPIS: string;
       OBSCOFINS: string;
       OBSISS: string;
       OBSINSS: string;
       OBSIR: string;
       SERIENF: STRING;
       dataemissaonf: string;
    end;
  TDM_Config = class(TDataModule)
    IBDB: TIBDatabase;
    IBTransaction: TIBTransaction;
    Q_Update: TIBQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM_Config: TDM_Config;

  // Variaveis de processo do Syslog no windows
  MPidExecutavel: Cardinal;
  MHandle: HWND;

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

  vprodutoCalculo: array of TProdutoCalculo;
  NumeroSerie : array of TNumeroSerie;

  VContaPagar : array of TContaPagar;
  VContas : array of TContas;
  VContasAntecipado : array of TContas;

  Vbaixa : array of TContas;
  PagamentoParcial : TPagamentoParcial;
  dadosContrato : TContrato;

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
  Vconciliacao : array of TConciliacaoBancaria;
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

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}
uses UTools_CLX;

procedure TDM_Config.DataModuleCreate(Sender: TObject);
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

      DM_Config.IBDB.Connected := false;
      Dm_Config.IBDB.DatabaseName :=ServidorBanco+':'+ArqBancoTrabalho;
      DM_Config.IBDB.Params.Values['user_name'] := UsuarioBanco;
      DM_Config.IBDB.Params.Values['password'] := SenhaBanco;
      Try
       DM_Config.IBDB.Connected := true;

      Except
       Exit;
      end;








end;

end.
