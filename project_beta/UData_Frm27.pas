unit UData_Frm27;

interface

uses
  SysUtils, Classes, DB, IBX.IBCustomDataSet, IBX.IBQuery, IBX.IBTable;

type
  TDM_Frm027 = class(TDataModule)
    IBQ_OFConferir: TIBQuery;
    IBQ_ItemOF: TIBQuery;
    DtS_QOFConferir: TDataSource;
    IBQ_SerieItem: TIBQuery;
    IBQ_OFConferirOF_COD: TIBStringField;
    IBQ_OFConferirOF_PRIORIDADE: TIBStringField;
    IBQ_OFConferirOF_RAZAOFAT: TIBStringField;
    IBQ_OFConferirOF_ITEM: TStringField;
    IBQ_OFConferirOF_SERIEITEM: TStringField;
    IBQ_ItemOFOF_PRODCOD: TIBStringField;
    IBQ_ItemOFOF_PRODDESCHARDR: TIBStringField;
    IBQ_SerieItemNUMSERIE: TIBStringField;
    IBQ_OFConferirOF_PREVISAOFAT: TDateTimeField;
    Dts_QItemOF: TDataSource;
    IBQ_Etiqueta: TIBQuery;
    DS_Etiqueta: TDataSource;
    IBQ_EtiquetaCX_OF: TIBStringField;
    IBQ_EtiquetaCX_NOTASAIDA: TIBStringField;
    IBQ_EtiquetaICX_NUM: TIBStringField;
    IBQ_EtiquetaICX_PROD: TIBStringField;
    IBQ_ImprimeETQ: TIBQuery;
    IBQ_UltimaCaixa: TIBQuery;
    IBQ_UltimaCaixaMAX: TIBStringField;
    IBQ_Caixa: TIBQuery;
    IBQ_ItemCaixa: TIBQuery;
    IBQ_SerieEstoque: TIBQuery;
    IBQ_EtiquetaICX_NF: TIBStringField;
    IBQ_OFEtiqueta: TIBQuery;
    DS_OFEtiqueta: TDataSource;
    IBQ_OFEtiquetaOF_COD: TIBStringField;
    IBQ_OFEtiquetaOF_PRIORIDADE: TIBStringField;
    IBQ_OFEtiquetaOF_RAZAOFAT: TIBStringField;
    IBQ_OFEtiquetaOF_PREVISAOFAT: TDateTimeField;
    IBQ_EtiquetaTPRDESCFATURA: TIBStringField;
    Qry_AlteraOF: TIBQuery;
    IBQ_OFConferirSituacao: TStringField;
    IBQ_OFConferirOF_FATURAMENTO: TIBStringField;
    IBQ_ImprimeETQDescricaoEtiqueta: TStringField;
    IBQ_ItensFaltantes: TIBQuery;
    IBQ_PecasFaltantes: TIBQuery;
    IBQ_ItensFaltantesTPRDESCFATURA: TIBStringField;
    IBQ_ItensFaltantesNUMSERIE: TIBStringField;
    IBQ_PecasFaltantesTPRDESCFATURA: TIBStringField;
    IBQ_PecasFaltantesNUMSERIE: TFloatField;
    IBQ_OFConferirOF_TRANSPORTADORA: TIBStringField;
    IBQ_OFConferirOF_PEDIDO: TIBStringField;
    IBQ_ImprimeETQOF_CODCLIENT: TIBStringField;
    IBQ_ImprimeETQOF_PLANTACLIENT: TIntegerField;
    IBQ_ImprimeETQOF_ENDENT: TIBStringField;
    IBQ_ImprimeETQOF_NUMENT: TIBStringField;
    IBQ_ImprimeETQOF_COMPLENT: TIBStringField;
    IBQ_ImprimeETQOF_BAIRROENT: TIBStringField;
    IBQ_ImprimeETQOF_CIDADEENT: TIBStringField;
    IBQ_ImprimeETQOF_UFENT: TIBStringField;
    IBQ_ImprimeETQOF_CEPENT: TIBStringField;
    IBQ_ImprimeETQOF_TRANSPORTADORA: TIBStringField;
    IBQ_ImprimeETQTCLCOD: TIBStringField;
    IBQ_ImprimeETQTCLRAZAO: TIBStringField;
    IBQ_ImprimeETQCX_OF: TIBStringField;
    IBQ_ImprimeETQCX_NUM: TIBStringField;
    IBQ_ImprimeETQCX_NOTASAIDA: TIBStringField;
    IBQ_ImprimeETQCX_PESO_BRUTO: TFloatField;
    IBQ_ImprimeETQCX_PESO_LIQ: TFloatField;
    IBQ_ImprimeETQCX_ITENS: TIntegerField;
    IBQ_ImprimeETQICX_PROD: TIBStringField;
    IBQ_ImprimeETQICX_ITENS: TIntegerField;
    IBQ_ImprimeETQTPRDESCFATURA: TIBStringField;
    IBQ_ImprimeETQOF_PRDESCRNF: TIBStringField;
    IBQ_OFConferirOF_LIBERASEPARACAO: TIBStringField;
    IBQ_OFConferirOF_LIBSEP_USUARIO: TIBStringField;
    IBQ_OFConferirOF_LIBSEP_DATAHORA: TDateTimeField;
    IBQ_OFConferirOF_DATA: TDateTimeField;
    procedure IBQ_OFConferirCalcFields(DataSet: TDataSet);
    procedure IBQ_ImprimeETQCalcFields(DataSet: TDataSet);
    function ChecaSequencia(anterior: string; atual: string): boolean;

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM_Frm027: TDM_Frm027;

implementation
Uses UdataConfig,  Utools_CLX;
{$R *.xfm}

procedure TDM_Frm027.IBQ_OFConferirCalcFields(DataSet: TDataSet);
var   lista: tstrings;
begin
  if Dm_frm027.IBQ_OFConferir.FieldByName('OF_FATURAMENTO').AsString = '2' then
    Dm_Frm027.IBQ_OFConferirSituacao.AsString := 'Aguardando Conferência'
  else
    if Dm_frm027.IBQ_OFConferir.FieldByName('OF_FATURAMENTO').AsString = '6' then
      Dm_Frm027.IBQ_OFConferirSituacao.AsString := 'Conferência Suspensa'
    else
      if Dm_frm027.IBQ_OFConferir.FieldByName('OF_FATURAMENTO').AsString = '7' then
        Dm_Frm027.IBQ_OFConferirSituacao.AsString := 'Em Conferência';

{   IBQ_ItemOF.Active:= False;
   IBQ_ItemOF.ParamByName('CODIGOOF').AsString := IBQ_OFConferirOF_COD.AsString;
   IBQ_ItemOF.Active:= True;
   IBQ_ItemOF.Last;
   IBQ_ItemOF.First;
   Try
     lista:= Tstringlist.Create ;
     Lista.Clear;
     Lista.BeginUpdate;
     While not  IBQ_ItemOF.Eof do
      Begin
       lista.Add(Ibq_itemof.Fields[1].asstring);
       Ibq_itemof.Next;
      end;
     Lista.EndUpdate;
     Form027.Grid_OF.Columns.Items[2].PickList := lista;
   finally
    //Lista.Free;
   end;


   IBQ_SerieItem.Active:= False;
   IBQ_SerieItem.ParamByName('CODIGOOF').AsString := IBQ_OFConferirOF_COD.AsString;
   IBQ_SerieItem.Active:= True;
   IBQ_SerieItem.Last;
   IBQ_SerieItem.First;
   Try
     lista:= Tstringlist.Create ;
     Lista.Clear;
     Lista.BeginUpdate;
     While not  IBQ_SerieItem.Eof do
      Begin
       lista.Add(IBQ_SerieItem.Fields[0].asstring);
       IBQ_SerieItem.Next;
      end;
     Lista.EndUpdate;
     Form027.Grid_OF.Columns.Items[3].PickList := lista;
   finally
    //Lista.Free;
   end;
  Form027.Grid_OF.Refresh;}
end;

function TDM_Frm027.ChecaSequencia(anterior: string; atual: string): boolean;
begin
  if length(anterior) > 1 then //checa se é um unico caracter
  begin
    if Copy(anterior, 1, length(anterior) - 1) = Copy(atual, 1, length(atual) - 1) then // verifica se o inicio do serial é igual
    begin //se for igual verifica se último dígito é sequencia
      if pos(copy(atual, length(atual), 1), SEQUENCIAS) =
        succ(pos(Copy(anterior, length(anterior), 1), SEQUENCIAS)) then
        ChecaSequencia := true
      else
        ChecaSequencia := false;
    end
    else // se o inicio do serial for diferente, verifica se pode ser final de dezena
      if ((Copy(anterior, length(anterior), 1) = '9') or (Copy(anterior, length(anterior), 1) = 'Z')) and
        (Copy(atual, length(atual), 1) = '0') then // se é final de dezena, chama a função novamente para verificar restante da sequencia
        ChecaSequencia := ChecaSequencia(Copy(anterior, 1, length(anterior) - 1), Copy(atual, 1, length(atual) - 1))
      else
        ChecaSequencia := false;
  end
  else
  begin //checa últimos dígitos para verificar se é sequencia
    if pos(copy(atual, length(atual), 1), SEQUENCIAS) =
      succ(pos(Copy(anterior, length(anterior), 1), SEQUENCIAS)) then
      ChecaSequencia := true
    else
      ChecaSequencia := false;
  end;
end;

procedure TDM_Frm027.IBQ_ImprimeETQCalcFields(DataSet: TDataSet);
var{$H+}descricaoproduto: string; {$H-}
  Q_DescricaoEtiqueta: TIBQuery;
  atualizou: boolean;
  produto, conectivo, ultimoserial: string;
begin
   Q_DescricaoEtiqueta := TIBQuery.Create(self);
   Q_DescricaoEtiqueta.Database := DM_Config.IBDB;
   Q_DescricaoEtiqueta.Active := false;
   Q_DescricaoEtiqueta.SQL.Text := 'Select Distinct ICX_SERIEPROD, ICX_PROD '+
                                   'From T_ITEM_CAIXA_SEPARACAO '+
                                   'Where ICX_PROD = '+#39+IBQ_ImprimeETQICX_PROD.AsString +#39+ ' AND '+
                                   ' ICX_OF = '+#39+IBQ_ImprimeETQCX_OF.AsString +#39+ ' AND '+
                                   ' ICX_NF = '+#39+IBQ_ImprimeETQCX_NOTASAIDA.AsString +#39+ ' AND '+
                                   ' ICX_NUM = '+#39+IBQ_ImprimeETQCX_NUM.AsString +#39+ ' '+
                                   'ORDER BY ICX_SERIEPROD ';
   Q_DescricaoEtiqueta.Active := true;
   while not (Q_DescricaoEtiqueta.Eof) do
      begin
         descricaoproduto := '';
         atualizou := true;
         produto := Q_DescricaoEtiqueta.FieldByName('ICX_PROD').AsString;
         // Inicia texto de serial
         descricaoproduto := retiraAcento(IBQ_ImprimeETQ.FieldbyName('TPRDESCFATURA').AsString) + ' ';
         descricaoproduto := descricaoproduto + Q_DescricaoEtiqueta.FieldbyName('ICX_SERIEPROD').AsString;
         ultimoserial := Q_DescricaoEtiqueta.FieldbyName('ICX_SERIEPROD').AsString;
         Q_DescricaoEtiqueta.Next;
         while (Q_DescricaoEtiqueta.FieldByName('ICX_PROD').AsString = produto) and
         not (Q_DescricaoEtiqueta.EOF) do
            begin
               // verifica se está na sequencia
               if ChecaSequencia(ultimoserial, Q_DescricaoEtiqueta.FieldbyName('ICX_SERIEPROD').AsString) then
                  begin
                     // é sequencia, atualiza conectivo para continuar checagem
                     atualizou := false;
                     ultimoserial := Q_DescricaoEtiqueta.FieldbyName('ICX_SERIEPROD').AsString;
                     conectivo := ' a ';
                  end
               else
                  begin
                     // não é sequencia, atualiza texto serial para reiniciar checagem
                     if atualizou then // verifica se o item esta isolado (true) ou é faixa (false)
                       descricaoproduto := descricaoproduto + ', '
                     else
                       descricaoproduto := descricaoproduto + conectivo + ultimoserial + ', ';
                     ultimoserial := Q_DescricaoEtiqueta.FieldbyName('ICX_SERIEPROD').AsString;
                     descricaoproduto := descricaoproduto + ultimoserial;
                     atualizou := true;
                  end;
               Q_DescricaoEtiqueta.Next;
            end;
         if atualizou then //finaliza para item isolado
            descricaoproduto := descricaoproduto + '.'
         else
            begin //finaliza para faixa
               descricaoproduto := descricaoproduto + conectivo + ultimoserial + '.';
            end;
         IBQ_ImprimeETQDescricaoEtiqueta.AsString := descricaoproduto;
      end;
end;

end.
