unit UTools_Clx;

interface

uses IniFiles, SysUtils, DB, IBX.IBDatabase, IBX.IBSQL, IBX.IBQuery, FMX.Forms, Windows,
  DateUtils, TlHelp32,ShellApi;


type

  TModo = (tmAlteracao, tmInclusao, tmVisualizacao, tmInativo);



const
   SEQUENCIAS = '0123456789';
   NUMEROS = '0123456789';
   MOEDA = '0123456789.,';
   MAIUSCULAS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
   MINUSCULAS = 'abcdefghijklmnopqrstuvwxyz';
   LETRAS = MAIUSCULAS + MINUSCULAS;
   SETE = 'AC' + 'AL' + 'AM' + 'BA' + 'CE' + 'GO' + 'ES' + 'MA' + 'MT' + 'MS' + 'PB' + 'PA' + 'PE' + 'PI' + 'RO' + 'RN' + 'TO' + 'AP';
   DOZE = 'MG' + 'PN' + 'SC' + 'RS' + 'RJ';
   DEZOITO = 'SP';
   LEATRAS_MINUSCULAS = MINUSCULAS + 'áéíóúàèìòùâêîôûäëïöüãõñç';
   LETRAS_MAIUSCULAS = MAIUSCULAS + 'ÁÉÍÓÚÀÈÌÒÙÂÊÎÔÛÄËÏÖÜÃÕÑÇ';
   sw : longint = 1366;
   sh : longint = 768;


var
  ErroVal: integer;
  MArqZPlImpressao, MArqSaidaImpressao: TextFile;
  MsaidaImpressao: string;

procedure Delay(MSecTime: word);
function AllTrim(DADO: string): string;
function VerificaIni(ArquivoINI, Grupo, Item, ValorDefault, Tarefa: string): string;
function WhatComm(PORTA: string): integer;
function ModeComm(VELOCIDADE, PARIDADE, DADOS, PARADA: string): string;
function FlowControl(FLUXO: string): integer;
function WhatFlow(DADO: integer): string;
function StrLeft(DADO: string; LEN: byte): string;
function StrRight(DADO: string; LEN: byte): string;
function PadL(DADO: string; COMPR: byte): string;
function PadR(DADO: string; COMPR: byte): string;
function PadC(DADO: string; COMPR: byte): string;
function LimpaCodigo(DADO: string; COMPR: byte): string;
function Criptografia(DADO: string; Monta: boolean): string;
function FormaCodigo(VALOR: integer; COMPR: byte): string;
function Upper(BASE: string): string;
function decimal(valor: string): string;
function FormatReal(valor: string): boolean;
function FormatDolar(valor: string): boolean;
function FormatEuro(valor: string): boolean;
function FormatPeso(valor: string): boolean;
function PadRLimpaCodigo(DADO: string; COMPR: byte): string;
function LimpaCodigoMOEDA(DADO: string; COMPR: byte): string;
function MostraDia(VALOR: integer; COMPR: byte): string;
function ValidaData(DADO: string): boolean;
function LimpaValor(DADO: string): string;
function contadecimal(valor: string): string;
function configuramoeda(valor: string; dolar: boolean; real: boolean): string;
function contadecimal6(valor: string): string;
function configuramoeda6OLD(valor: string; dolar: boolean; real: boolean): string;
function configuramoeda6(valor: string; dolar: boolean; real: boolean): string;
function TotalValor(valor: string; tipomoeda: char; multiplo: Integer): string;
function MergeDados(LinhaZpl: string; forma: integer): string;
function Filtra(FDado: string): string;
function FiltraEPL(FDado: string): string;
function Right(DADO: string; LEN: byte): string;
function PorExtenso(DADO, MoedaSingular, MoedaPlural, DecimalSingular, DecimalPlural: string): string;
function FormaValor(VALOR: real; COMPR, CASAS: byte): string;
function TiraPonto(VALOR: string): string;
function RetiraCaracter(DADO: string; Antigo: char): string;
function TrocaCaracter(DADO: string; Antigo, Novo: char): string;
function TiraAspas(DADO: string; Antigo, Novo: char): string;
function LimpaMoeda(Valor, Moeda: string): string;
function funcObtemNovoCodigo(pDB: TIBDatabase; psNomeTabela, psNomeCampo: string): string;
function funcDelete(pDB: TIBDatabase; psNomeTabela, psClausulaWHere: string): boolean;
function funcValidaData(psData: string): boolean;
function funcValidaInteiro(psNum: string): boolean;
function RetiraVirgula(valor: string): string;
function TeclaValida(Key: word): boolean;
function TeclaValidaChar(Key: WideChar): boolean;
procedure ImprimeArquivo(NomeArquivo: string; LerSequencial: boolean);
function NumeroCaixa: string;
function GeraNumeroSerie2(xinicial: string; xfinal: string; xproduto: string; xnf: string; xpedido: string; xqtd: integer): Boolean;
function Decimais(Valor: string): integer;
function Arredonda(Valor : Real; CasasDecimais : integer):Real;
function DataExtenso (DataBase: string):string;
function TiraMilhar (DADO: string): string;
function IsEmpty(campo : string) : boolean;
function OnlyChar(campo : String) : boolean;
function Limpa(campo :string):string;//BY NOBOW BOY
function OnlyNumber(campo : String) : boolean; //BY NOBOW BOY
function Numero (campo : string) : boolean;
function OnlyNumberInteger(campo : String) : boolean; //BY NOBOW BOY
Function ReplaceString(ToBeReplaced, ReplaceWith : string; TheString :string):string;
Function Inscricao( Inscricao, Tipo : String ) : Boolean;
function ValidarCPF(Numero: String): Boolean;
function LimpaCaracter(campo, caracter :String) :String;
Function Atualiza : Boolean;
Procedure Executa(nome : String);
function BuscaProcesso(NomeExecutavel : String) : Boolean;
function Is4DigitYear: Boolean; // BY NOBOW BOY
function criaLote : String; // BY NOBOW BOY
function GeraNumeroSerie(xinicial: string; xfinal: string; xproduto: string; xitem: String; xnf: string; xnfserie: string; xinvoice : string; xpedido: string; xqtd: integer; xlote : String; xtransf : String): Boolean;
function formaNumeroOF(nof : String) : String;//BY NOBOW BOY
function PadZero(DADO: string; COMPR: byte): string;
function isValidEmail(email : String) : boolean; // BY NOBOW BOY
function retiraAcento ( str: String ): String; // BY NOBOW BOY
function lowTexto(campo : String) : String; // BY NOBOW BOY
function upaTexto(campo : String) : String; // BY NOBOW BOY
function upFirstLetter(campo : String) : String; // BY NOBOW BOY
function deixaApenasNumeros(txt : String) : String; // BY NOBOW BOY
function calculaComissao(tipoVenda : integer) : boolean; //BY NOBOW BOY
function ultimodiadomes(mes: integer;ano: integer) : integer;
function PegaMesAtual:string;
function MoedatoFloat(valor: string; moeda: char) : real;
function FloattoMoeda(valor: real; moeda: char) : string;
function LimpaUnder(DADO: string): string;
//------------------------------------------------------------------------------
function GetComputerNetName: string;
Function GetUserFromWindows: string;
function SecsToHMS(Secs: LongInt): string;
function HMStoSecs(Tempo:String):Integer;
//------------------------------------------------------------------------------
function SomaUmMes(DADO : string): string;
function ExtraiChaveNFE(arquivo :string):string;
function MudaDataSefaz(DADO: string):string;
function RemoveQuebraLinha(sString: string): string;
//------------------------------------------------------------------------------
function GetPIDExecutavel( const ANome: String ): Cardinal;
function GetHWNDFromPID( const pid: Cardinal ): HWND;
function ObtemIBPT(NCM, mercado: string): real;
function FormatDolar6(valor: string): boolean;
function FormatEuro6(valor: string): boolean;
function FormatReal6(valor: string): boolean;
function StringtoFloat(valor: string) : real;
function Arredonda6(Valor : Real):Real;
function IniciaImpressao(NomeArquivo: string): boolean;
procedure GeraArquivoImpressao(NomeArquivo: string);
function FinalizaImpressao(NomeArquivo: string): boolean;
function ObtemPartilha:boolean;
function FormataNumeroOF(NumOF: string): string; // retorna o número da OF formatado no formato 999999/AA onde AA é o ano atual
function AchaChaveNFE(nf: string; serienf: string):string;
function dgCreateProcess(const FileName: string): boolean;
function FormataNumeroOS(NumOS:string):string;
function AtualizaHistoricoProduto(produto,campo,valorantigo,valornovo,nform:string):boolean;
function BuscaProduto(Produto : string): string;
function BuscaEmailContato(Cliente: string; Planta:Integer; Contato:string):string;
function BuscaFornecedor(Codigo : string; Planta : integer): string;
procedure ExecutaCreditoAutomatico(CodOF: string);
function VerificaCreditoAutomatico: boolean;
procedure ExecutaCreditoAutomaticoContrato(Lancamento: string);
function VerificaDigitoModulo11(Codigo : string):boolean;
function InsereMensagemMovimento(datamov: TDatetime; mensagem: string): boolean;
function FormatReal4c(valor: string): boolean;
function getPercentual(tipo : Integer; percentual : Double): Double;
function LiberaOFEtiqueta(CodigoUsuario: string): boolean;
procedure OpenPDF(aFile : TFileName; TypeForm : Integer = SW_NORMAL);

implementation

uses udataconfig, IDGlobal;

function SomaUmMes(DADO : string): string;
var dia, mes, ano    : integer;
    xdia, xmes, xano : integer;
    xdata : string;
begin
  dia := StrToInt(Copy(Dado, 1, 2));
  mes := StrToInt(Copy(Dado, 4, 2));
  ano := StrToInt(Copy(Dado, 7, 4));

  xdia := dia - 1;
  xmes := mes + 1;
  if xmes = 13 then
    begin
      xmes := 1;
      xano := ano + 1;
    end
  else
    xano := ano;

  xdata := LimpaCodigo(IntToStr(xdia),2)+'/'+LimpaCodigo(IntToStr(xmes),2)+'/'+LimpaCodigo(IntToStr(xano),4);
  if ValidaData(xdata) then
    SomaUmMes := xdata;
end;     { SomaUmMes }


 



//------------------------------------------------------------------------------

function SecsToHMS(Secs: LongInt): string;
var
   Hrs, Min: Word;
   H, M, S: String;
begin
   Hrs := Secs div 3600;
   Secs := Secs mod 3600;
   Min := Secs div 60;
   Secs := Secs mod 60;
   H:=FormatFloat('#00',Hrs);
   M:=FormatFloat('00',Min);
   S:=FormatFloat('00',Secs);
   Result:=Concat(H,':',M,':',S);
end;

function HMStoSecs(Tempo:String):Integer;
var
   h,m,s,x:Integer;
begin

   try
      if Length(Tempo) = 9 then
         begin
            h:=StrtoInt(Copy(Tempo,1,3));
            m:=StrtoInt(Copy(Tempo,5,2));
            s:=StrtoInt(Copy(Tempo,8,2));
            x:=(s+(m*60)+(h*3600));
         end
      else if Length(Tempo) = 5 then
         begin
            h:=StrtoInt(Copy(Tempo,1,2));
            m:=StrtoInt(Copy(Tempo,4,2));
            x:=((m*60)+(h*3600));
         end
      else if Length(Tempo) <= 8 then
         begin
            try
               h:=StrtoInt(Copy(Tempo,1,2));
               m:=StrtoInt(Copy(Tempo,4,2));
               s:=StrtoInt(Copy(Tempo,7,2));
               x:=(s+(m*60)+(h*3600));
            except
               h:=StrtoInt(Copy(Tempo,1,3));
               m:=StrtoInt(Copy(Tempo,5,2));
               x:=((m*60)+(h*3600));
            end;
         end;
   except
      x := 0;
   end;

   Result:=x;

end;




//******************************************************************************

function GetComputerNetName: string;
var
  buffer: array[0..255] of char;
  size: dword;
begin
  size := 256;
  if GetComputerName(buffer, size) then
    Result := buffer
  else
    Result := ''
end;

Function GetUserFromWindows: string;
Var
   UserName : string;
   UserNameLen : Dword;
Begin
   UserNameLen := 255;
   SetLength(userName, UserNameLen) ;
   If GetUserName(PChar(UserName), UserNameLen) Then
     Result := Copy(UserName,1,UserNameLen - 1)
   Else
     Result := 'Unknown';
End;


//******************************************************************************

function calculaComissao(tipoVenda : integer) : boolean;
var
   qry : TIBQuery;
begin


   qry := TIBQuery.Create(nil);
   qry.Database := DM_Config.IBDB;

   qry.Close;
   qry.SQL.Clear;
   qry.SQL.Add('select * from t_tipos_venda v');
   qry.SQL.Add('where v.sno_calculacomissao = :Vsim');
   qry.SQL.Add('      and');
   qry.SQL.Add('      v.sno_sit = :Vtipo');
   qry.ParamByName('Vsim').AsString := 'S';
   qry.ParamByName('Vtipo').AsInteger := tipoVenda;
   qry.Open;

   if qry.IsEmpty then
      Result := False
   else
      Result := True;

   //qry.Free;
   //qry := nil;
   FreeAndNil(qry);
end;

//******************************************************************************

function lowTexto(campo : String) : String;
var
   i,
   aux : integer;

   txt : String;

begin


   txt := alltrim(campo);

   for i:=1 to length(txt) do
   begin
      aux := pos(txt[i], LETRAS_MAIUSCULAS);
      if  aux > 0 then
         txt[i] := LEATRAS_MINUSCULAS[aux];
   end;


   Result := txt;

end;


function upaTexto(campo : String) : String;
var
   i,
   aux : integer;

   txt : String;

begin


   txt := alltrim(campo);

   for i:=1 to length(txt) do
   begin
      aux := pos(txt[i], LEATRAS_MINUSCULAS);
      if  aux > 0 then
         txt[i] := LETRAS_MAIUSCULAS[aux];
   end;


   Result := txt;

end;


function upFirstLetter(campo : String) : String;
var
   i : integer;

   tmp,
   txt : String;

   primeiraLetra,
   alterou: boolean;
begin

   primeiraLetra := True;
   alterou := False;
   tmp := '';
   txt := alltrim(campo);
   txt := LowerCase(txt);


   for i:=1 to length(txt) do
   begin

      if (pos(txt[i],LETRAS) > 0) then
      begin
         if primeiraLetra then
         begin
            tmp := tmp + upper(txt[i]);
            primeiraLetra := False;
            alterou := True;
         end
         else
         begin
            alterou := False;
            tmp := tmp + txt[i];
         end;
      end
      else
      begin
         primeiraLetra := True;
         alterou := False;
         tmp := tmp + txt[i];
      end;

   end;

   Result := tmp;

end;

function deixaApenasNumeros(txt : String) : String;
var
   i : integer;

   tmp : String;
begin

   tmp := '';

   for i:=1 to length(txt) do
   begin
      if pos(txt[i], NUMEROS) > 0 then
         tmp := tmp + txt[i];
   end;

   Result := tmp;


end;


//******************************************************************************
function retiraAcento ( str: String ): String;
var
   i: Integer;
begin

   for i := 1 to Length ( str ) do
      begin
          case str[i] of
             'á': str[i] := 'a';
             'é': str[i] := 'e';
             'í': str[i] := 'i';
             'ó': str[i] := 'o';
             'ú': str[i] := 'u';
             'à': str[i] := 'a';
             'è': str[i] := 'e';
             'ì': str[i] := 'i';
             'ò': str[i] := 'o';
             'ù': str[i] := 'u';
             'â': str[i] := 'a';
             'ê': str[i] := 'e';
             'î': str[i] := 'i';
             'ô': str[i] := 'o';
             'û': str[i] := 'u';
             'ä': str[i] := 'a';
             'ë': str[i] := 'e';
             'ï': str[i] := 'i';
             'ö': str[i] := 'o';
             'ü': str[i] := 'u';
             'ã': str[i] := 'a';
             'õ': str[i] := 'o';
             'ñ': str[i] := 'n';
             'ç': str[i] := 'c';
             'Á': str[i] := 'A';
             'É': str[i] := 'E';
             'Í': str[i] := 'I';
             'Ó': str[i] := 'O';
             'Ú': str[i] := 'U';
             'À': str[i] := 'A';
             'È': str[i] := 'E';
             'Ì': str[i] := 'I';
             'Ò': str[i] := 'O';
             'Ù': str[i] := 'U';
             'Â': str[i] := 'A';
             'Ê': str[i] := 'E';
             'Î': str[i] := 'I';
             'Ô': str[i] := 'O';
             'Û': str[i] := 'U';
             'Ä': str[i] := 'A';
             'Ë': str[i] := 'E';
             'Ï': str[i] := 'I';
             'Ö': str[i] := 'O';
             'Ü': str[i] := 'U';
             'Ã': str[i] := 'A';
             'Õ': str[i] := 'O';
             'Ñ': str[i] := 'N';
             'Ç': str[i] := 'C';
          end; //FIM DO CASE
      end; // FIM DO FOR

   Result := str;
   
end;




function isValidEmail(email : String) : boolean;
var
   i,
   ponto,
   arroba : integer;

   tmp : string;
begin

    Result := False;

    if length(email) < 6 then
        exit
    else
        begin
            ponto := 0;
            arroba := 0;
            if (copy(email,1,1) = '@') or (copy(email,1,1) = '.') then
                exit;
                
            for i:= 1 to length(email) do
                begin
                    tmp := email[i];
                    if email[i] = '@' then
                        inc(arroba)
                    else if email[i] = '.' then
                        inc(ponto);
                end;
            if (arroba = 1) and (ponto >= 1) then
                result := true;
        end;

end;




procedure Delay(MSecTime: word);
var
  Tempo1, Tempo2: TDateTime;
  Horas, Minutos, Segundos, MSegundos: Word;
  ElapsedTime: LongInt;
begin
  Tempo1 := Now;
  repeat
    Tempo2 := Now - Tempo1;
    DecodeTime(Tempo2, Horas, Minutos, Segundos, MSegundos);
    ElapsedTime := ((Horas * 3600 + Minutos * 60 + Segundos) * 1000) + MSegundos;
  until ElapsedTime >= MSecTime;
end;

function AllTrim(DADO: string): string;
var
  TEMP: string;
begin
  TEMP := DADO;
  while (Length(TEMP) > 0) and (TEMP[1] = #32) do
    Delete(TEMP, 1, 1);
  while (Length(TEMP) > 0) and (TEMP[Length(TEMP)] = #32) do
    Delete(TEMP, Length(TEMP), 1);
  AllTrim := TEMP;
end; { AllTrim }

function VerificaIni(ArquivoINI, Grupo, Item, ValorDefault, Tarefa: string): string;
var WINDOWSINI: TIniFile;
  Resposta: string;
begin
  WINDOWSINI := TIniFile.Create(ArquivoINI);
  if Tarefa = 'LER' then
  begin
    Resposta := WINDOWSINI.ReadString(Grupo, Item, ValorDefault);
    VerificaINI := Resposta;
  end
  else
  begin
    WINDOWSINI.WriteString(Grupo, Item, ValorDefault);
    VerificaINI := '';
  end;
  WINDOWSINI.Free;
end;

function WhatComm(PORTA: string): integer;
var
  TEMP: integer;
begin
  TEMP := 2;
  if StrLeft(PORTA, 3) = 'COM' then
    TEMP := StrToInt(Copy(PORTA, 4, 1))
  else
    if StrLeft(PORTA, 3) = 'LPT' then
      TEMP := 0
    else
      TEMP := -1;
  WhatComm := TEMP;
end; { WhatComm }

function ModeComm(VELOCIDADE, PARIDADE, DADOS, PARADA: string): string;
var
  TEMP: string;
begin
  TEMP := '9600,N,8,1';
  if ((StrToInt(VELOCIDADE) > 0) and
    (UpCase(PARIDADE[1]) in ['E', 'O', 'N']) and
    (StrToInt(DADOS) >= 4) and
    (StrToInt(PARADA) >= 1)) then
    TEMP := AllTrim(VELOCIDADE) + ',' +
      Chr(Ord(UpCase(PARIDADE[1])) + 32) + ',' +
      DADOS + ',' + PARADA;
  ModeComm := TEMP
end; { ModeComm }

function FlowControl(FLUXO: string): integer;
var
  TEMP: integer;
begin
  TEMP := 0;
  if FLUXO = 'XonXoff' then TEMP := 1;
  if FLUXO = 'RtsCts' then TEMP := 2;
  if FLUXO = 'Both' then TEMP := 3;
  FlowControl := TEMP;
end; { FlowControl }

function WhatFlow(DADO: integer): string;
begin
  case DADO of
    0: WhatFlow := 'None';
    1: WhatFlow := 'XonXoff';
    2: WhatFlow := 'RtsCts';
    3: WhatFlow := 'Both';
  end;
end; { WhatFlow }

function StrLeft(DADO: string; LEN: byte): string;
begin
  StrLeft := Copy(DADO, 1, LEN);
end; { StrLeft }

function StrRight(DADO: string; LEN: byte): string;
begin
  StrRight := Copy(DADO, Length(DADO) - LEN + 1, LEN);
end; { StrRight }

function PadL(DADO: string; COMPR: byte): string;
var
  TEMP: string;
begin
  TEMP := AllTrim(DADO);
  while Length(TEMP) < COMPR do
    TEMP := #32 + TEMP;
  PadL := Copy(TEMP, 1, COMPR);
end; { PadL }

function PadR(DADO: string; COMPR: byte): string;
var
  TEMP: string;
begin
  TEMP := AllTrim(DADO);
  while Length(TEMP) < COMPR do
    TEMP := TEMP + #32;
  PadR := Copy(TEMP, 1, COMPR);
end; { PadR }

function PadC(DADO: string; COMPR: byte): string;
var
  TEMP: string;
  POS: byte;
begin
  TEMP := AllTrim(DADO);
  POS := 0;
  while Length(TEMP) < COMPR do
  begin
    Inc(POS);
    if Odd(POS) then TEMP := TEMP + #32
    else TEMP := #32 + TEMP;
  end;
  PadC := Copy(TEMP, 1, COMPR);
end; { PadC }

function LimpaCodigo(DADO: string; COMPR: byte): string;
var
  TEMP: string;
  i: byte;
begin
  TEMP := DADO;
  for i := Length(TEMP) downto 1 do
    if Pos(TEMP[i], NUMEROS) <= 0 then
      Delete(TEMP, i, 1);
  while Length(TEMP) < COMPR do
    TEMP := '0' + TEMP;
  LimpaCodigo := TEMP;
end; { LimpaCodigo }

function Criptografia(DADO: string; Monta: boolean): string;
var TEMP: string;
  X, FatorPar, FatorImpar: integer;
begin
  X := 1;
  TEMP := '';
  FatorPar := 2;
  FatorImpar := 3;
  while (X <= Length(DADO)) do
  begin
    if Monta then
      TEMP := TEMP + CHR(ROUND((FatorImpar * ORD(DADO[X])) / FatorPar))
    else
      TEMP := TEMP + CHR(ROUND((FatorPar * ORD(DADO[X])) / FatorImpar));
    Inc(X);
    Inc(FatorPar, 2);
    Inc(FatorImpar, 2);
  end;
  Criptografia := TEMP;
end;

function FormaCodigo(VALOR: integer; COMPR: byte): string;
var
  TempStr: string;

begin
  TempStr := IntToStr(VALOR);
  FormaCodigo := LimpaCodigo(TempStr, COMPR);
end; { FormaValor }

function Upper(BASE: string): string;
var
  TEMP: string;
  I: byte;
begin
  TEMP := BASE;
  for I := 1 to Length(TEMP) do
    TEMP[I] := UpCase(TEMP[I]);
  Upper := TEMP;
end; { Upper }

function decimal(valor: string): string;
var aux, x, y: integer;
var concatena: string;
begin
  concatena := '';
  decimal := '';
  aux := 0;
  aux := pos(',', valor);
  if aux = 0 then
    concatena := valor + ',00'
  else
    concatena := Copy(valor, 1, aux) +
      Copy(valor, aux + 1, 3);
  decimal := concatena;
end;

function FormatReal(valor: string): boolean;
var x: integer;
  y: string;
  Resultado: boolean;
begin
  Resultado := False;
  x := length(Alltrim(valor));
  if (x < 4) or (valor = '0,00') or (x = 7) or (valor = '0.000,00') then
    Resultado := False
  else
    if x <= 6 then
    begin
      y := limpacodigomoeda(valor, 6);
      x := length(y);
      if (y[x] in ['0'..'9']) then
        if (y[x - 1] in ['0'..'9']) then
          if (y[x - 2] in [',']) then
            if (y[x - 3] in ['0'..'9']) then
              if (y[x - 4] in ['0'..'9']) or (y[2] = '') then
                if (y[x - 5] in ['0'..'9']) or (y[1] = '') then
                  Resultado := True;
    end
    else
      if x > 6 then
      begin
        y := limpacodigomoeda(valor, 10);
        x := length(y);
        if (y[x] in ['0'..'9']) then
          if (y[x - 1] in ['0'..'9']) then
            if (y[x - 2] in [',']) then
              if (y[x - 3] in ['0'..'9']) then
                if (y[x - 4] in ['0'..'9']) or (y[2] = '') then
                  if (y[x - 5] in ['0'..'9']) or (y[1] = '') then
                    if (y[x - 6] in ['.']) then
                      if (y[x - 7] in ['0'..'9']) then
                        if (y[x - 8] in ['0'..'9']) then
                          if (y[x - 9] in ['0'..'9']) then
                            Resultado := True;
      end;
  FormatReal := Resultado;
end;

function FormatReal4c(valor: string): boolean;
var x: integer;
  y: string;
  Resultado: boolean;
begin
  Resultado := False;
  x := length(Alltrim(valor));
  if (x < 4) or (valor = '0,00') or (x = 7) or (valor = '0.000,00') then
    Resultado := False
  else
    if x <= 6 then
    begin
      y := limpacodigomoeda(valor, 6);
      x := length(y);
      if (y[x] in ['0'..'9']) then
        if (y[x - 1] in ['0'..'9']) then
          if (y[x - 2] in [',']) then
            if (y[x - 3] in ['0'..'9']) then
              if (y[x - 4] in ['0'..'9']) or (y[2] = '') then
                if (y[x - 5] in ['0'..'9']) or (y[1] = '') then
                  Resultado := True;
    end
    else
      if x > 6 then
      begin
        y := limpacodigomoeda(valor, 12);
        x := length(y);
        if (y[x] in ['0'..'9']) then
          if (y[x - 1] in ['0'..'9']) then
            if (y[x - 2] in ['0'..'9']) then
              if (y[x - 3] in ['0'..'9']) then
                if (y[x - 4] in [',']) then
                  if (y[x - 5] in ['0'..'9']) then
                    if (y[x - 6] in ['0'..'9']) or (y[2] = '') then
                      if (y[x - 7] in ['0'..'9']) or (y[1] = '') then
                        if (y[x - 8] in ['.']) then
                          if (y[x - 9] in ['0'..'9']) then
                            if (y[x - 10] in ['0'..'9']) then
                              if (y[x - 11] in ['0'..'9']) then
                                Resultado := True;
      end;
  FormatReal4c := Resultado;
end;



function FormatDolar(valor: string): boolean;
var x: integer;
  y: string;
  Resultado: boolean;
begin
  Resultado := False;
  x := length(alltrim(valor));
  if (x < 4) or (valor = '0.00') or (x = 7) or (valor = '0,000.00') then
    Resultado := False
  else
    if x <= 6 then
    begin
      y := limpacodigomoeda(valor, 6);
      x := length(y);
      if (y[x] in ['0'..'9']) then
        if (y[x - 1] in ['0'..'9']) then
          if (y[x - 2] in ['.']) then
            if (y[x - 3] in ['0'..'9']) then
              if (y[x - 4] in ['0'..'9']) or (y[2] = '') then
                if (y[x - 5] in ['0'..'9']) or (y[1] = '') then
                  Resultado := True;
    end
    else
      if x > 6 then
      begin
        y := limpacodigomoeda(valor, 10);
        x := length(y);
        if (y[x] in ['0'..'9']) then
          if (y[x - 1] in ['0'..'9']) then
            if (y[x - 2] in ['.']) then
              if (y[x - 3] in ['0'..'9']) then
                if (y[x - 4] in ['0'..'9']) or (y[2] = '') then
                  if (y[x - 5] in ['0'..'9']) or (y[1] = '') then
                    if (y[x - 6] in [',']) then
                      if (y[x - 7] in ['0'..'9']) then
                        if (y[x - 8] in ['0'..'9']) then
                          if (y[x - 9] in ['0'..'9']) then
                            Resultado := True;
      end;
  FormatDolar := Resultado;
end;

function FormatEuro(valor: string): boolean;
var x: integer;
  y: string;
  Resultado: boolean;
begin
  Resultado := False;
  x := length(Alltrim(valor));
  if (x < 4) or (valor = '0,00') or (x = 7) or (valor = '0.000,00') then
    Resultado := False
  else
    if x <= 6 then
    begin
      y := limpacodigomoeda(valor, 6);
      x := length(y);
      if (y[x] in ['0'..'9']) then
        if (y[x - 1] in ['0'..'9']) then
          if (y[x - 2] in [',']) then
            if (y[x - 3] in ['0'..'9']) then
              if (y[x - 4] in ['0'..'9']) or (y[2] = '') then
                if (y[x - 5] in ['0'..'9']) or (y[1] = '') then
                  Resultado := True;
    end
    else
      if x > 6 then
      begin
        y := limpacodigomoeda(valor, 10);
        x := length(y);
        if (y[x] in ['0'..'9']) then
          if (y[x - 1] in ['0'..'9']) then
            if (y[x - 2] in [',']) then
              if (y[x - 3] in ['0'..'9']) then
                if (y[x - 4] in ['0'..'9']) or (y[2] = '') then
                  if (y[x - 5] in ['0'..'9']) or (y[1] = '') then
                    if (y[x - 6] in ['.']) then
                      if (y[x - 7] in ['0'..'9']) then
                        if (y[x - 8] in ['0'..'9']) then
                          if (y[x - 9] in ['0'..'9']) then
                            Resultado := True;
      end;
  FormatEuro := Resultado;
end;


function FormatPeso(valor: string): boolean;
var x: integer;
  y: string;
  Resultado: boolean;
begin
  Resultado := False;
  x := length(alltrim(valor));
  if (x < 5) or (valor = '0.000') or (x = 8) or (valor = '0,000.000') then
    Resultado := False
  else
    if x <= 7 then
    begin
      y := limpacodigomoeda(valor, 7);
      x := length(y);
      if (y[x] in ['0'..'9']) then
        if (y[x - 1] in ['0'..'9']) then
          if (y[x - 2] in ['0'..'9']) then
            if (y[x - 3] in ['.']) then
              if (y[x - 4] in ['0'..'9']) or (y[3] = '') then
                if (y[x - 5] in ['0'..'9']) or (y[2] = '') then
                  if (y[x - 6] in ['0'..'9']) or (y[1] = '') then
                    Resultado := True;
    end
    else
      if x > 7 then
      begin
        y := limpacodigomoeda(valor, 11);
        x := length(y);
        if (y[x] in ['0'..'9']) then
          if (y[x - 1] in ['0'..'9']) then
            if (y[x - 2] in ['0'..'9']) then
              if (y[x - 3] in ['.']) then
                if (y[x - 4] in ['0'..'9']) or (y[3] = '') then
                  if (y[x - 5] in ['0'..'9']) or (y[2] = '') then
                    if (y[x - 6] in ['0'..'9']) or (y[1] = '') then
                      if (y[x - 7] in [',']) then
                        if (y[x - 8] in ['0'..'9']) then
                          if (y[x - 9] in ['0'..'9']) then
                            if (y[x - 10] in ['0'..'9']) then
                            Resultado := True;
      end;
  FormatPeso := Resultado;
end;




function LimpaCodigoMOEDA(DADO: string; COMPR: byte): string;
var
  TEMP: string;
  i: byte;
begin
  TEMP := DADO;
  for i := Length(TEMP) downto 1 do
    if Pos(TEMP[i], MOEDA) <= 0 then
      Delete(TEMP, i, 1);
  while Length(TEMP) < COMPR do
    TEMP := '0' + TEMP;
  LimpaCodigoMOEDA := TEMP;
end; { LimpaCodigoMOEDA }

function MostraDia(VALOR: integer; COMPR: byte): string;
var
  TempStr: string;

begin
  if (Valor = 0) then
    MostraDia := ''
  else
  begin
    TempStr := IntToStr(VALOR);
    MostraDia := LimpaCodigo(TempStr, COMPR);
  end;
end; { MostraDia }


function ValidaData(DADO: string): boolean;
const
  DiasMes: array[1..12] of word = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
var
  TEMP: boolean;
  Ano, Mes, Dia: word;
begin
  TEMP := false;
  Val(Copy(DADO, 1, 2), Dia, ErroVal);
  Val(Copy(DADO, 4, 2), Mes, ErroVal);
  Val(Copy(DADO, 7, 4), Ano, ErroVal);
  if (Ano > 1900) and (Mes >= 1) and (Mes <= 12) then
  begin
    if ((Ano mod 4) = 0) and (Mes = 2) then //ano bissexto: Fevereiro c/29 dias
    begin
      if (Dia >= 1) and (Dia <= 29) then
        TEMP := true;
    end
    else //ano normal: Fevereiro c/28 dias
    begin
      if (Dia >= 1) and (Dia <= DiasMes[Mes]) then
        TEMP := true;
    end;
  end;
  ValidaData := TEMP;
end; { ValidaData }

function LimpaValor(DADO: string): string;
var
  TEMP: string;
  i: byte;
  ValorReal: real;
begin
  TEMP := DADO;
  for i := Length(TEMP) downto 1 do
    if Pos(TEMP[i], NUMEROS) <= 0 then
      Delete(TEMP, i, 1);

  if AllTrim(TEMP) <> '' then
  begin
    Val(TEMP, ValorReal, ErroVal);
    if ErroVal <> 0 then TEMP := '';
  end;
  LimpaValor := TEMP;
end; { LimpaValor }

function contadecimal(valor: string): string;
var aux, x, y, z: integer;
  concatena, prox: string;
  auxvalor: string;
begin
  concatena := '';
  contadecimal := '';
  {
  a linha Comentada abaixo está fazendo arredondamento errado
  substitui o round por FloatToStrF com duas casas decimais

  Francisco 01/08/2003
  }
//  auxvalor := FloatToStr(Round(StrToFloat(valor)*100)/100);
  auxvalor := RetiraVirgula(FloatToStrF((StrTofloat(valor) * 100) / 100, ffNumber, 15, 2));
  aux := 0;
  aux := pos(',', auxvalor);

  if aux = 0 then
    concatena := auxvalor + '.00'
  else
  begin
    y := 0;
    if (Length(auxvalor) - aux) > 2 then
    begin
      if strtoint(auxvalor[aux + 3]) > 5 then
        y := 1;

      prox := LimpaCodigo(auxvalor[aux + 1], 1);
      prox := prox + LimpaCodigo(auxvalor[aux + 2], 1);
      x := strtoint(prox);
      z := x + y;

      concatena := copy(auxvalor, 1, aux) + inttostr(z);
      if (Length(concatena) - aux) = 2 then
        concatena := Copy(auxvalor, 1, aux) + Copy(auxvalor, aux + 1, 2)
      else
        if (Length(concatena) - aux) = 1 then
          concatena := Copy(auxvalor, 1, aux) + Copy(auxvalor, aux + 1, 2);

    end
    else
    begin
      if (Length(auxvalor) - aux) = 2 then
        concatena := Copy(auxvalor, 1, aux) + Copy(auxvalor, aux + 1, 2)
      else
        if (Length(auxvalor) - aux) = 1 then
        begin
          concatena := Copy(auxvalor, 1, aux) + Copy(auxvalor, aux + 1, 2);
          concatena := concatena + '0';
        end;
    end;
  end;
  contadecimal := concatena;
end;


function configuramoeda(valor: string; dolar: boolean; real: boolean): string;
var tamanho : integer ;
    TEMP,   decimal,
    milhar, resultado : string;
begin
  // transforma o valor a ser formatado em um valor inteiro sem zeros à esquerda
  TEMP := IntToStr(StrToInt64(LimpaCodigo(Valor, Length(AllTrim(Valor)))));

  Resultado := '';

  // Define os separadores de milhar e decimal de acordo com a moeda solicitada
  if Dolar then
    begin
      decimal := '.';
      milhar  := ',';
    end;

  if Real then
    begin
      decimal := ',';
      milhar  := '.';
    end;

  // verifica o tamanho do valor a ser convertido
  tamanho := length(TEMP);

  // define o valor dos centavos já concatenando o separador do decimal
  Resultado := Decimal + Copy (TEMP, Tamanho-1, 2);

  // Alterado 09/06/2006 - Luís Marcelo
  // Corrige valores menores que dez centavos
  if (Copy(valor,1,1) = '0') and (length(valor)=4) and (copy(valor,3,1)='0') then
     Resultado := copy(Resultado,1,1)+'0'+copy(resultado,2,1);
  // FIM

  // retira o valor dos centavos da string a ser convertida
  TEMP := Copy (TEMP, 1, tamanho - 2);
  tamanho := tamanho - 2;

  // enquanto existirem milhares a serem formatados
  while tamanho > 3 do
    begin
      // insere o milhar formatando na string já com o separador do milhar
      Resultado := Milhar + Copy (TEMP, Tamanho-2, 3) + Resultado;

      // retira o valor do milhar utilizado da string a ser convertida
      TEMP := Copy (TEMP, 1, tamanho - 3);
      tamanho := tamanho - 3;
    end;

  // Caso exista valor a ser utilizado é concatenado à string
  if tamanho > 0 then
    Resultado := TEMP + Resultado;
  // Alterado 09/06/2006 - Luís Marcelo
  // Corrige valores menores que 1
  if (Copy(resultado,1,1) = ',') or (Copy(resultado,1,1) = '.') then
     Resultado :='0'+Resultado;
  // FIM
  ConfiguraMoeda := Resultado;
end;

function contadecimal6(valor: string): string;
var aux, x, y, z: integer;
  concatena, prox: string;
  auxvalor: string;
begin
  concatena := '';
  contadecimal6 := '';
  {
  a linha Comentada abaixo está fazendo arredondamento errado
  substitui o round por FloatToStrF com duas casas decimais

  Francisco 01/08/2003
  }
//  auxvalor := FloatToStr(Round(StrToFloat(valor)*100)/100);

  { LM - 04/09/2015 - Mudança para utilizar 6 casas decimais ao invés de 2 }

  auxvalor := RetiraVirgula(FloatToStrF((StrTofloat(valor) * 1000000) / 1000000, ffNumber, 15, 6));

  aux := 0;
  aux := pos(',', auxvalor);

  if aux = 0 then
    concatena := auxvalor + '.000000'
  else
     begin
        y := 0;
        if (Length(auxvalor) - aux) > 7 then  // aux = posição da vírgula // se for maior que 7 (7 casas decimais ou mais)
           begin
              if strtoint(auxvalor[aux + 7]) > 5 then // verifica se a sétima casa decimal é maior que 5, se for, tem que arredondar a sexta casa
                 y := 1;


              prox := LimpaCodigo(copy(auxvalor,(aux+1),6), 6); // retira as seis casas decimais
//              prox := prox + LimpaCodigo(auxvalor[aux + 6], 1);
              x := strtoint(prox); // converte para inteiro
              z := x + y;  // soma o arredondamento da última casa

              concatena := copy(auxvalor, 1, aux) + inttostr(z); // junta a parte inteira com a decimal
//              if (Length(concatena) - aux) = 2 then                                        //
//                 concatena := Copy(auxvalor, 1, aux) + Copy(auxvalor, aux + 1, 2)          //
//              else                                                                         // papo de bêbado!!!
//                 if (Length(concatena) - aux) = 1 then                                     //
//                    concatena := Copy(auxvalor, 1, aux) + Copy(auxvalor, aux + 1, 2);      //
           end
        else
           begin
              concatena := Copy(auxvalor, 1, aux) + LimpaCodigo(Copy(auxvalor,aux+1,6),6);
//              if (Length(auxvalor) - aux) = 2 then
//                 concatena := Copy(auxvalor, 1, aux) + Copy(auxvalor, aux + 1, 2)
//              else
//                 if (Length(auxvalor) - aux) = 1 then
//                    begin
//                       concatena := Copy(auxvalor, 1, aux) + Copy(auxvalor, aux + 1, 2);
//                       concatena := concatena + '0';
//                    end;
           end;
     end;
  contadecimal6 := concatena;
end;


function configuramoeda6OLD(valor: string; dolar: boolean; real: boolean): string;
var tamanho : integer ;
    TEMP,   decimal,
    milhar, resultado : string;
begin
  // transforma o valor a ser formatado em um valor inteiro sem zeros à esquerda
  TEMP := IntToStr(StrToInt64(LimpaCodigo(Valor, Length(AllTrim(Valor)))));

  Resultado := '';

  // Define os separadores de milhar e decimal de acordo com a moeda solicitada
  if Dolar then
    begin
      decimal := '.';
      milhar  := ',';
    end;

  if Real then
    begin
      decimal := ',';
      milhar  := '.';
    end;

  // verifica o tamanho do valor a ser convertido
  tamanho := length(TEMP);

  // Alterado 04/09/2015 - LM - Alterado para tabalhar com 6 casas decimais
  // define o valor dos centavos já concatenando o separador do decimal
  Resultado := Decimal + Copy (TEMP, Tamanho-5, 6);

  // Alterado 09/06/2006 - Luís Marcelo
  // Corrige valores menores que dez centavos
  //  if (Copy(valor,1,1) = '0') and (length(valor)=4) and (copy(valor,3,1)='0') then
  //   Resultado := copy(Resultado,1,1)+'0'+copy(resultado,2,1);
  // FIM

  // retira o valor dos centavos da string a ser convertida
  TEMP := Copy (TEMP, 1, tamanho - 6);
  tamanho := tamanho - 6;

  // enquanto existirem milhares a serem formatados
  while tamanho > 3 do
    begin
      // insere o milhar formatando na string já com o separador do milhar
      Resultado := Milhar + Copy (TEMP, Tamanho-2, 3) + Resultado;

      // retira o valor do milhar utilizado da string a ser convertida
      TEMP := Copy (TEMP, 1, tamanho - 3);
      tamanho := tamanho - 3;
    end;

  // Caso exista valor a ser utilizado é concatenado à string
  if tamanho > 0 then
    Resultado := TEMP + Resultado;
  // Alterado 09/06/2006 - Luís Marcelo
  // Corrige valores menores que 1
  if (Copy(resultado,1,1) = ',') or (Copy(resultado,1,1) = '.') then
     Resultado :='0'+Resultado+'0';
  // FIM
  ConfiguraMoeda6OLD := Resultado;
end;

function configuramoeda6(valor: string; dolar: boolean; real: boolean): string;
var tamanho : integer ;
    TEMP,   decimal,
    milhar, resultado : string;
    QtosInteiros, QtosDecimais, PosicaoSeparador : integer;
    ParteInteira, ParteDecimal : string;
begin

  QtosInteiros := 0;
  QtosDecimais := 0;
  PosicaoSeparador := 0;
  PosicaoSeparador := pos(',', Valor);
  if PosicaoSeparador = 0 then
    PosicaoSeparador := pos('.', Valor);

  QtosInteiros := PosicaoSeparador - 1;
  QtosDecimais := Length(Valor)-PosicaoSeparador;

  ParteInteira := Copy (Valor, 1, QtosInteiros);
  ParteDecimal := Copy (Valor, PosicaoSeparador+1, QtosDecimais);

//  if Length(ParteDecimal) > 6 then
//    ParteDecimal := Copy(ParteDecimal, 1, 6)
//  else
//    if Length(ParteDecimal) < 6 then
//      ParteDecimal := LimpaDecimal (ParteDecimal, 6);

  // transforma o valor a ser formatado em um valor inteiro sem zeros à esquerda
  // Samuca - 22/10/2019 - quando só tem casa decimal dá pau
//  TEMP := IntToStr(StrToInt64(LimpaCodigo(Valor, Length(AllTrim(Valor)))));

  Resultado := '';

  // Define os separadores de milhar e decimal de acordo com a moeda solicitada
  if Dolar then
    begin
      decimal := '.';
      milhar  := ',';
    end;

  if Real then
    begin
      decimal := ',';
      milhar  := '.';
    end;

  // verifica o tamanho do valor a ser convertido
  // Samuca - 22/10/2019 - quando só tem decimal o tamanho fica errado
  //tamanho := length(TEMP);
  tamanho := QtosInteiros + QtosDecimais;

  // Alterado 04/09/2015 - LM - Alterado para tabalhar com 6 casas decimais
  // define o valor dos centavos já concatenando o separador do decimal
  // Samuca - 22/10/2019 - quando só tem decimal o tamanho fica errado
  //Resultado := Decimal + Copy (TEMP, Tamanho-5, 6);
  Resultado := Decimal + ParteDecimal;

  // Alterado 09/06/2006 - Luís Marcelo
  // Corrige valores menores que dez centavos
  //  if (Copy(valor,1,1) = '0') and (length(valor)=4) and (copy(valor,3,1)='0') then
  //   Resultado := copy(Resultado,1,1)+'0'+copy(resultado,2,1);
  // FIM

  // retira o valor dos centavos da string a ser convertida
  // Samuca - 22/10/2019 - quando só tem decimal o tamanho fica errado
//  TEMP := Copy (TEMP, 1, tamanho - 6);
  TEMP := ParteInteira;
  tamanho := tamanho - 6;

  // enquanto existirem milhares a serem formatados
  while tamanho > 3 do
    begin
      // insere o milhar formatando na string já com o separador do milhar
      Resultado := Milhar + Copy (TEMP, Tamanho-2, 3) + Resultado;

      // retira o valor do milhar utilizado da string a ser convertida
      TEMP := Copy (TEMP, 1, tamanho - 3);
      tamanho := tamanho - 3;
    end;

  // Caso exista valor a ser utilizado é concatenado à string
  if tamanho > 0 then
    Resultado := TEMP + Resultado;
  // Alterado 09/06/2006 - Luís Marcelo
  // Corrige valores menores que 1
  if (Copy(resultado,1,1) = ',') or (Copy(resultado,1,1) = '.') then
//     Resultado :='0'+Resultado+'0';
     Resultado :='0'+Resultado;
  // FIM
  ConfiguraMoeda6 := Resultado;
end;



function TotalValor(valor: string; tipomoeda: char; multiplo: Integer): string;
var Val_Ref: Real;
  Val_Str: string;
begin
  val_Ref := (strtofloat(Limpavalor(valor)) * multiplo);
  val_Ref := round(Val_Ref) / 100;
  case tipomoeda of
    'D': Val_str := configuramoeda(contadecimal(floattostr(val_Ref)), True, False);
    'R': Val_str := configuramoeda(contadecimal(floattostr(val_Ref)), False, True);
  end;

  TotalValor := Val_Str;
end;


function MergeDados(LinhaZpl: string; forma: integer): string;
const
  AbreColchete: PChar = '[';
  FechaColchete: PChar = ']';
var
  Inicio: PChar;
  Fim: PChar;
  MinhaLinha: PChar;
  Variavel: string;
  LinhaAlterada: string;
  PosIni: integer;
  PosFim: integer;
  Processando: Boolean;
  Posicaomemo: integer;
begin
    Processando := True;
    while Processando do
        begin
            MinhaLinha := Pchar(LinhaZPL);
            Inicio := StrPos(MinhaLinha, AbreColchete);
            if Inicio <> nil then
                begin//001
                    Fim := StrPos(MinhaLinha, FechaColchete);
                    if Fim <> nil then
                        begin//002
                              PosIni := strtoint(inttostr(Inicio - MinhaLinha)) + 1;
                              PosFim := strtoint(inttostr(Fim - MinhaLinha)) + 1;
                              Variavel := Copy(MinhaLinha, PosIni, (PosFim - PosIni) + 1);
                              LinhaAlterada := Copy(MinhaLinha, 1, PosIni - 1);
                              if Variavel = '[descricao_produto]' then
                                  LinhaAlterada := LinhaAlterada + TiraAspas(Merge_descprod, #34, #39)
                              else if Variavel = '[cod_trabalho]' then
                                  LinhaAlterada := LinhaAlterada + Merge_codtrab
                              else if Variavel = '[cod_trabalho2]' then
                                  LinhaAlterada := LinhaAlterada + Merge2_codtrab
                              else if Variavel = '[notafiscal]' then
                                  LinhaAlterada := LinhaAlterada + Merge_nota
                              else if Variavel = '[serie]' then
                                  LinhaAlterada := LinhaAlterada + Merge_serie
                              else if Variavel = '[cxsnotafiscal]' then
                                  LinhaAlterada := LinhaAlterada + etqcxnotasaida
                              else if Variavel = '[cxscaixa]' then
                                  LinhaAlterada := LinhaAlterada + etqcxnum
                              else if Variavel = '[cxscaixafinal]' then
                                  LinhaAlterada := LinhaAlterada + etqcxfinal
                              else if Variavel = '[cxsrazaocliente]' then
                                  LinhaAlterada := LinhaAlterada + TiraAspas(etqclrazao, #34, #39)
                              else if Variavel = '[cxsendereco1]' then
                                  LinhaAlterada := LinhaAlterada + alltrim(TiraAspas(etqendent, #34, #39)) + ' ' + alltrim(etqnument) + ' ' + alltrim(etqcomplent)
                              else if Variavel = '[cxsendereco2]' then
                                  LinhaAlterada := LinhaAlterada + alltrim(TiraAspas(etqbairroent, #34, #39)) + ' ' + alltrim(TiraAspas(etqcidadeent, #34, #39)) + ' ' + alltrim(etqufent)
                              else if Variavel = '[cxstransportadora]' then
                                  LinhaAlterada := LinhaAlterada + TiraAspas(etqtransportadora, #34, #39)
                              else if Variavel = '[cxspesobruto]' then
                                  LinhaAlterada := LinhaAlterada + etqcxpesobruto
                              else if Variavel = '[cxspesoliquido]' then
                                  LinhaAlterada := LinhaAlterada + etqcxpesoliq
                              else if Variavel = '[cxsqdeitens]' then
                                  LinhaAlterada := LinhaAlterada + etqcxitens
                              else if Variavel = '[cxsproduto]' then
                                  begin//003
                                      if linhamemo < 12 then    //ultima linha da etiqueta
                                          //if not(DM_Frm027.IBQ_ImprimeETQ.Eof) then
//                                              if linhamemo = Form035.memoetiqueta.Lines.Count then
//                                                  begin//003.1
//                                                      if linhamemo > 0 then
//                                                          DM_Frm027.IBQ_ImprimeETQ.Next;
//                                                      if (linhamemo + (length(DM_Frm027.IBQ_ImprimeETQDescricaoEtiqueta.AsString)/66)) < 12 then //66 caracteres por linha
//                                                          begin//003.2
//                                                              posicaomemo := 1;
//                                                              While posicaomemo < length(DM_Frm027.IBQ_ImprimeETQDescricaoEtiqueta.AsString) do
//                                                                  begin//003.3
//                                                                      // Samuca 23/06/2009
//                                                                      Form035.memoetiqueta.Lines.Add(TiraAspas(Copy(DM_Frm027.IBQ_ImprimeETQDescricaoEtiqueta.AsString,posicaomemo,66), #34, #39));
//                                                                      posicaomemo := posicaomemo + 66;
//                                                                  end;//003.3
//                                                              if not(DM_Frm027.IBQ_ImprimeETQ.EOF) then
//                                                                  begin//003.4
//                                                                      linhamemo := linhamemo + 1;
//                                                                      LinhaAlterada := LinhaAlterada + Form035.memoetiqueta.Lines.Strings[linhamemo-1];
//                                                                  end;//003.4
//                                                          end;//003.2
//                                                  end//003.1
//                                              else if not(DM_Frm027.ibq_imprimeetq.eof) then
//                                                  begin
//                                                      linhamemo := linhamemo + 1;
//                                                      LinhaAlterada := LinhaAlterada + Form035.memoetiqueta.Lines.Strings[linhamemo-1];
//                                                  end;
                                  end//003
                              else if Variavel = '[cxsquantidade]' then
                                  LinhaAlterada := LinhaAlterada + Merge_CxsQuantidade
                              else if Variavel = '[cxscodclient]' then
                                  LinhaAlterada := LinhaAlterada + etqcodclient
                              else if Variavel = '[cxsplantaclient]' then
                                  LinhaAlterada := LinhaAlterada + etqplantaclient
                              else if Variavel = '[numeroserie]' then
                                  LinhaAlterada := LinhaAlterada + Merge_NumeroSerie
                              else if Variavel = '[numeroserie2]' then
                                  LinhaAlterada := LinhaAlterada + Merge2_NumeroSerie
                              else if Variavel = '[numerolote]' then
                                  LinhaAlterada := LinhaAlterada + Merge_NumeroLote
                              else if Variavel = '[desnumeroserie]' then
                                  begin
                                      if Trim(Merge_NumeroSerie) <> 'QUANTIDADE' then
                                          LinhaAlterada := LinhaAlterada + Merge_NumeroSerie
                                      else
                                          LinhaAlterada := LinhaAlterada + '';
                                  end
                              else if Variavel = '[desnumeroserie2]' then
                                  begin
                                      if Trim(Merge2_NumeroSerie) <> 'QUANTIDADE' then
                                          LinhaAlterada := LinhaAlterada + Merge2_NumeroSerie
                                      else
                                          LinhaAlterada := LinhaAlterada + '';
                                  end
                              else if Variavel = '[codsistema]' then
                                  LinhaAlterada := LinhaAlterada + Merge_CodSistema
                              else if Variavel = '[codsistema2]' then
                                  LinhaAlterada := LinhaAlterada + Merge2_CodSistema
                              else if Variavel = '[desckit]' then
                                  LinhaAlterada := LinhaAlterada + TiraAspas(Merge_DescKit, #34, #39)
                              else if Variavel = '[desckit1]' then
                                  LinhaAlterada := LinhaAlterada + TiraAspas(Merge_DescKit1, #34, #39)
                              else if Variavel = '[desckit2]' then
                                  LinhaAlterada := LinhaAlterada + TiraAspas(Merge_DescKit2, #34, #39)
                              else if Variavel = '[cxslogo]' then
                                  LinhaAlterada := LinhaAlterada + etqcxslogo
                              else if Variavel = '[qty]' then
                                      begin
                                         // LM - 14/10/2010 - No caso de merge_quantidade vazia, joga 1 para ela
                                         if strtoint(LimpaCodigo(Trim(Merge_Quantidade), 4)) < 1 then
                                            Merge_Quantidade := '0001';
                                         LinhaAlterada := LinhaAlterada + LimpaCodigo(Trim(Merge_Quantidade), 4);
                                      end
                              else if (Variavel = '[Linha_1]') and (Merge_Linha1 <> '') then
                                  LinhaAlterada := LinhaAlterada + Trim(TiraAspas(Merge_Linha1, #34, #39))
                              else if (Variavel = '[Linha_2]') and (Merge_Linha2 <> '') then
                                  LinhaAlterada := LinhaAlterada + Trim(TiraAspas(Merge_Linha2, #34, #39))
                              else if (Variavel = '[Linha_3]') and (Merge_Linha3 <> '') then
                                  LinhaAlterada := LinhaAlterada + Trim(TiraAspas(Merge_Linha1, #34, #39))
                              else if (Variavel = '[Linha_1b]') and (Merge2_Linha1 <> '') and (alltrim(Merge2_Numeroserie)<> '') then
                                  LinhaAlterada := LinhaAlterada + Trim(TiraAspas(Merge2_Linha1, #34, #39))
                              else if (Variavel = '[Linha_2b]') and (Merge2_Linha2 <> '') and (alltrim(Merge2_Numeroserie)<> '') then
                                  LinhaAlterada := LinhaAlterada + Trim(TiraAspas(Merge2_Linha2, #34, #39))
                              else if (Variavel = '[Linha_3b]') and (Merge2_Linha3 <> '') and (alltrim(Merge2_Numeroserie)<> '') then
                                  LinhaAlterada := LinhaAlterada + Trim(TiraAspas(Merge2_Linha3, #34, #39))
                              else if (Variavel = '[codbar2]') and (alltrim(Merge2_Numeroserie)<> '') then
                                  LinhaAlterada := 'B452,60,0,1,2,2,40,N,"[codsistema2][numeroserie2]"'
                              else if (Variavel = '[numeroos]') then
                                  LinhaAlterada := LinhaAlterada + NumeroOSEtq
                              else if (Variavel = '[numacessorio]') then
                                  LinhaAlterada := LinhaAlterada + inttostr(EtqOSnumacessorio)
                              else if (Variavel = '[totalacessorios]') then
                                  LinhaAlterada := LinhaAlterada + inttostr(EtqOStotalacessorios)
                              else if (Variavel = '[acessorio]') then
                                  LinhaAlterada := LinhaAlterada + EtqOSAcessorio
                              else if (Variavel = '[acessorio2]') then
                                  LinhaAlterada := LinhaAlterada + EtqOSAcessorio2
                              else if (Variavel = '[reimpressao]') then
                                  LinhaAlterada := LinhaAlterada + inttostr(EtqOSreimpressao)
                              else if (Variavel = '[numeronf]') then
                                  LinhaAlterada := LinhaAlterada + EtqOSnumeronf
                              else if (Variavel = '[serienf]') then
                                  LinhaAlterada := LinhaAlterada + EtqOSserienf
                              else if (Variavel = '[qtdeacessorios]') then
                                  LinhaAlterada := LinhaAlterada + inttostr(EtqOSqtdeacessorios);
                        end;//002
                    LinhaAlterada := LinhaAlterada + Copy(LinhaZPL, PosFim + 1, StrLen(MinhaLinha));
                    LinhaZPL := pchar(LinhaAlterada);
                end//001
            else
                Processando := False;

        end;// FIM DO WHILE

    Processando := False;
//    MergeDados := FiltraEPL(LinhaZPL);
    MergeDados := LinhaZPL;
end;



{
function MergeDados(LinhaZpl: string; forma: integer): string;
const
  AbreColchete: PChar = '[';
  FechaColchete: PChar = ']';
var
  Inicio: PChar;
  Fim: PChar;
  MinhaLinha: PChar;
  Variavel: string;
  LinhaAlterada: string;
  PosIni: integer;
  PosFim: integer;
  Processando: Boolean;
  Posicaomemo: integer;
begin
  Processando := True;
  while Processando do
  begin
    MinhaLinha := Pchar(LinhaZPL);
    Inicio := StrPos(MinhaLinha, AbreColchete);
    if Inicio <> nil then
    begin
      Fim := StrPos(MinhaLinha, FechaColchete);
      if Fim <> nil then
      begin
        PosIni := strtoint(inttostr(Inicio - MinhaLinha)) + 1;
        PosFim := strtoint(inttostr(Fim - MinhaLinha)) + 1;
        Variavel := Copy(MinhaLinha, PosIni, (PosFim - PosIni) + 1);
        LinhaAlterada := Copy(MinhaLinha, 1, PosIni - 1);
        if Variavel = '[descricao_produto]' then
          LinhaAlterada := LinhaAlterada + Merge_descprod
        else
          if Variavel = '[cod_trabalho]' then
            LinhaAlterada := LinhaAlterada + Merge_codtrab
          else
            if Variavel = '[notafiscal]' then
              LinhaAlterada := LinhaAlterada + Merge_nota
            else
              if Variavel = '[serie]' then
                LinhaAlterada := LinhaAlterada + Merge_serie
              else
                if Variavel = '[cxsnotafiscal]' then
                  LinhaAlterada := LinhaAlterada + etqcxnotasaida
                else
                  if Variavel = '[cxscaixa]' then
                    LinhaAlterada := LinhaAlterada + etqcxnum
                  else
                    if Variavel = '[cxscaixafinal]' then
                      LinhaAlterada := LinhaAlterada + etqcxfinal
                    else
                      if Variavel = '[cxsrazaocliente]' then
                        LinhaAlterada := LinhaAlterada + etqclrazao
                      else
                        if Variavel = '[cxsendereco1]' then
                          LinhaAlterada := LinhaAlterada + alltrim(etqendent) + ' ' + alltrim(etqnument) + ' ' + alltrim(etqcomplent)
                        else
                          if Variavel = '[cxsendereco2]' then
                            LinhaAlterada := LinhaAlterada + alltrim(etqbairroent) + ' ' + alltrim(etqcidadeent) + ' ' + alltrim(etqufent)
                          else
                            if Variavel = '[cxstransportadora]' then
                              LinhaAlterada := LinhaAlterada + etqtransportadora
                            else
                              if Variavel = '[cxspesobruto]' then
                                LinhaAlterada := LinhaAlterada + etqcxpesobruto
                              else
                                if Variavel = '[cxspesoliquido]' then
                                  LinhaAlterada := LinhaAlterada + etqcxpesoliq
                                else
                                  if Variavel = '[cxsqdeitens]' then
                                    LinhaAlterada := LinhaAlterada + etqcxitens
                                  else
                                    if Variavel = '[cxsproduto]' then
                                    begin
                                      if linhamemo < 12 then    //ultima linha da etiqueta
                                         if not(DM_Frm027.IBQ_ImprimeETQ.Eof) then
                                             if linhamemo = Form035.memoetiqueta.Lines.Count then
                                              begin
                                                   if linhamemo > 0 then
                                                      begin
                                                         DM_Frm027.IBQ_ImprimeETQ.Next;
                                                      end;
                                                   if (linhamemo + (length(DM_Frm027.IBQ_ImprimeETQDescricaoEtiqueta.AsString)/66)) < 12 then //66 caracteres por linha
                                                      begin
                                                         posicaomemo := 1;
                                                         While posicaomemo < length(DM_Frm027.IBQ_ImprimeETQDescricaoEtiqueta.AsString) do
                                                            begin
                                                               Form035.memoetiqueta.Lines.Add(Copy(DM_Frm027.IBQ_ImprimeETQDescricaoEtiqueta.AsString,posicaomemo,66));
                                                               posicaomemo := posicaomemo + 66;
                                                            end;
                                                         if not(DM_Frm027.IBQ_ImprimeETQ.EOF) then
                                                            begin
                                                               linhamemo := linhamemo + 1;
                                                               LinhaAlterada := LinhaAlterada + Form035.memoetiqueta.Lines.Strings[linhamemo-1];
                                                            end;
                                                      end;
                                                end
                                             else
                                                if not(DM_Frm027.ibq_imprimeetq.eof) then
                                                   begin
                                                      linhamemo := linhamemo + 1;
                                                      LinhaAlterada := LinhaAlterada + Form035.memoetiqueta.Lines.Strings[linhamemo-1];
                                                   end;
                                    end
                                    else
                                      if Variavel = '[cxsquantidade]' then
                                      begin
{                                        if not (DM_Frm027.IBQ_ImprimeETQ.Eof) then
                                        begin
                                          DM_Cadastro.IB_Pesquisa.active := false;
                                          DM_Cadastro.IB_Pesquisa.SQL.Clear;
                                          DM_Cadastro.IB_Pesquisa.SQL.Add('Select SUM(ICX_ITENS) ');
                                          DM_Cadastro.IB_Pesquisa.SQL.Add('From T_ITEM_CAIXA_SEPARACAO ');
                                          DM_Cadastro.IB_Pesquisa.SQL.Add('Where (ICX_OF = ' + CHR(39) + etqcxof + CHR(39) + ' ) AND ');
                                          DM_Cadastro.IB_Pesquisa.SQL.Add(' (ICX_PROD = ' + CHR(39) + DM_Frm027.IBQ_ImprimeETQICX_PROD.AsString + CHR(39) + ' ) AND ');
                                          DM_Cadastro.IB_Pesquisa.SQL.Add(' (ICX_NUM = ' + CHR(39) + LimpaCodigo(DM_Frm027.IBQ_ImprimeETQCX_NUM.AsString, 3) + CHR(39) + ')');
                                          DM_Cadastro.IB_Pesquisa.Active := true;
                                          if DM_Cadastro.IB_Pesquisa.IsEmpty then
                                            etqcxprodquantidade := '000'
                                          else
                                            etqcxprodquantidade := LimpaCodigo(DM_Cadastro.IB_Pesquisa.Fields[0].AsString, 3);
                                          LinhaAlterada := LinhaAlterada + etqcxprodquantidade;
                                          DM_Frm027.IBQ_ImprimeETQ.Next;
                                          etqcxprod := DM_Frm027.IBQ_ImprimeETQTPRDESCFATURA.AsString;
                                          etqcxprodquantidade := LimpaCodigo(DM_Frm027.IBQ_ImprimeETQICX_ITENS.AsString, 3);
                                        end
                                        else
                                          LinhaAlterada := LinhaAlterada + ' ';
} {                                     end
                                      else
                                        if Variavel = '[cxscodclient]' then
                                          LinhaAlterada := LinhaAlterada + etqcodclient
                                        else
                                          if Variavel = '[cxsplantaclient]' then
                                            LinhaAlterada := LinhaAlterada + etqplantaclient
                                          else
                                            if Variavel = '[numeroserie]' then
                                              LinhaAlterada := LinhaAlterada + Merge_NumeroSerie
                                            else
                                             if Variavel = '[desnumeroserie]' then
                                               begin
                                                 if Trim(Merge_NumeroSerie) <> 'QUANTIDADE' then
                                                   LinhaAlterada := LinhaAlterada + Merge_NumeroSerie
                                                 else
                                                   LinhaAlterada := LinhaAlterada + '';
                                               end
                                             else
                                              if Variavel = '[codsistema]' then
                                                LinhaAlterada := LinhaAlterada + Merge_CodSistema
                                              else
                                                if Variavel = '[desckit]' then
                                                  LinhaAlterada := LinhaAlterada + Merge_DescKit
                                                else
                                                if Variavel = '[desckit1]' then
                                                  LinhaAlterada := LinhaAlterada + Merge_DescKit1
                                                else
                                                if Variavel = '[desckit2]' then
                                                  LinhaAlterada := LinhaAlterada + Merge_DescKit2
                                                else
                                                  if Variavel = '[cxslogo]' then
                                                    LinhaAlterada := LinhaAlterada + etqcxslogo
                                                  else
                                                    if Variavel = '[qty]' then
                                                      LinhaAlterada := LinhaAlterada + LimpaCodigo(Trim(Merge_Quantidade), 4)
                                                      else
                                                        if Variavel = '[Linha_1]' then
                                                          LinhaAlterada := LinhaAlterada + Trim(Merge_Linha1)
                                                        else
                                                           if Variavel = '[Linha_2]' then
                                                            LinhaAlterada := LinhaAlterada + Trim(Merge_Linha2)
                                                          else
                                                             if Variavel = '[Linha_3]' then
                                                              LinhaAlterada := LinhaAlterada + Trim(Merge_Linha3);
      end;
      LinhaAlterada := LinhaAlterada + Copy(LinhaZPL, PosFim + 1, StrLen(MinhaLinha));
      LinhaZPL := pchar(LinhaAlterada);
    end
    else
      Processando := False;
  end;
  Processando := False;
  MergeDados := LinhaZPL;
end;
}
function Filtra(FDado: string): string;
var FDTemp: string;
  FDField: array[1..47] of string;
  FDLength,
    FDkk, FDlf,
    FDpp: integer;
  FDBase: string;
  FDPChar: Pchar;
begin
  FDTemp := FDado;
  FDLength := 47;
  if Length(ALLTRIM(FDTemp)) = 0 then
    Filtra := FDTemp
  else
  begin
    FDField[01] := 'Ç_80';
    FDField[02] := 'é_82';
    FDField[03] := 'â_83';
    FDField[04] := 'à_85';
    FDField[05] := 'ç_87';
    FDField[06] := 'ê_88';
    FDField[07] := 'è_8a';
    FDField[08] := 'î_8c';
    FDField[09] := 'ì_8d';
    FDField[10] := 'É_90';
    FDField[11] := 'ô_93';
    FDField[12] := 'ò_95';
    FDField[13] := 'û_96';
    FDField[14] := 'ù_97';
    FDField[15] := 'á_a0';
    FDField[16] := 'í_a1';
    FDField[17] := 'ó_a2';
    FDField[18] := 'ú_a3';
    FDField[19] := 'ñ_a4';
    FDField[20] := 'Ñ_a5';
    FDField[21] := 'ª_a6';
    FDField[22] := 'º_a7';
    FDField[23] := '½_ab';
    FDField[24] := '¼_ac';
    FDField[25] := 'Á_b5';
    FDField[26] := 'Â_b6';
    FDField[27] := 'À_b7';
    FDField[28] := '©_b8';
    FDField[29] := 'ã_c6';
    FDField[30] := 'Ã_C7';
    FDField[31] := 'Ê_d2';
    FDField[32] := 'Í_d6';
    FDField[33] := 'È_d4';
    FDField[34] := 'Î_d7';
    FDField[35] := 'Ì_de';
    FDField[36] := 'Ô_e2';
    FDField[37] := 'Ò_e3';
    FDField[38] := 'Û_ea';
    FDField[39] := 'Ù_eb';
    FDField[40] := 'Ó_e0';
    FDField[41] := 'õ_e4';
    FDField[42] := 'Õ_e5';
    FDField[43] := 'Ú_e9';
    FDfield[44] := '¾_f3';
    FDfield[45] := '¹_fb';
    FDfield[46] := '³_fc';
    FDfield[47] := '²_fd';
    for FDkk := 1 to FDLength do
    begin
      FDBase := Copy(FDField[FDkk], 1, 1);
      FDPchar := StrPos(Pchar(FDTemp), pchar(FDBase));
      while FDpchar <> nil do
      begin
        if FDpchar <> nil then
          FDpp := StrToInt(IntToStr(FDPchar - pchar(FDTemp))) + 1
        else
          FDpp := 0;
        FDlf := Length(FDTemp);
        if FDpp <> 0 then
          FDTemp := StrLeft(FDTemp, byte(FDpp) - 1) + StrRight(FDfield[FDkk], 3) + StrRight(FDTemp, FDlf - FDpp);
        FDPchar := StrPos(Pchar(FDTemp), pchar(FDBase));
      end;
    end;
    Filtra := FDTemp
  end;
end;

// Samuca - 23/06/2009
function FiltraEPL(FDado: string): string;
var FDTemp: string;
  FDField: array[1..48] of string;
  FDLength,
    FDkk, FDlf,
    FDpp: integer;
  FDBase: string;
  FDPChar: Pchar;
begin
  FDTemp := FDado;
  FDLength := 48;
  if Length(ALLTRIM(FDTemp)) = 0 then
    FiltraEPL := FDTemp
  else
  begin
    FDField[01] := 'Ç128';
    FDField[02] := 'é130';
    FDField[03] := 'â131';
    FDField[04] := 'à133';
    FDField[05] := 'ç135';
    FDField[06] := 'ê136';
    FDField[07] := 'è138';
    FDField[08] := 'î140';
    FDField[09] := 'ì141';
    FDField[10] := 'É144';
    FDField[11] := 'ô147';
    FDField[12] := 'ò149';
    FDField[13] := 'û150';
    FDField[14] := 'ù151';
    FDField[15] := 'á160';
    FDField[16] := 'í161';
    FDField[17] := 'ó162';
    FDField[18] := 'ú163';
    FDField[19] := 'ñ164';
    FDField[20] := 'Ñ165';
    FDField[21] := 'ª166';
    FDField[22] := 'º167';
    FDField[23] := '½171';
    FDField[24] := '¼172';
    FDField[25] := 'Á181';
    FDField[26] := 'Â182';
    FDField[27] := 'À183';
    FDField[28] := '©184';
    FDField[29] := 'ã198';
    FDField[30] := 'Ã199';
    FDField[31] := 'Ê210';
    FDField[32] := 'Í214';
    FDField[33] := 'È212';
    FDField[34] := 'Î215';
    FDField[35] := 'Ì222';
    FDField[36] := 'Ô226';
    FDField[37] := 'Ò227';
    FDField[38] := 'Û234';
    FDField[39] := 'Ù235';
    FDField[40] := 'Ó224';
    FDField[41] := 'õ228';
    FDField[42] := 'Õ229';
    FDField[43] := 'Ú233';
    FDfield[44] := '¾243';
    FDfield[45] := '¹251';
    FDfield[46] := '³252';
    FDfield[47] := '²253';
    FDfield[48] := '®169';
    for FDkk := 1 to FDLength do
    begin
      FDBase := Copy(FDField[FDkk], 1, 1);
      FDPchar := StrPos(Pchar(FDTemp), pchar(FDBase));
      while FDpchar <> nil do
      begin
        if FDpchar <> nil then
          FDpp := StrToInt(IntToStr(FDPchar - pchar(FDTemp))) + 1
        else
          FDpp := 0;
        FDlf := Length(FDTemp);
        if FDpp <> 0 then
          FDTemp := StrLeft(FDTemp, byte(FDpp) - 1) + CHR(StrToInt(StrRight(FDfield[FDkk], 3))) + StrRight(FDTemp, FDlf - FDpp);
        FDPchar := StrPos(Pchar(FDTemp), pchar(FDBase));
      end;
    end;
    FiltraEPL := FDTemp
  end;
end;


function Right(DADO: string; LEN: byte): string;
begin
  Right := Copy(DADO, Length(DADO) - LEN + 1, LEN);
end; { Right }

function PorExtenso(DADO, MoedaSingular, MoedaPlural, DecimalSingular, DecimalPlural: string): string;
// Esta funcao recebe um valor numerico no formato de 9,99 até 999.999.999.999,99 e faz a sua avaliacao
// fornecendo a escrita por extenso do valor.
// A analise é feita utilizando sempre o conceito de que temos um numero no formato de centena
// 999, esta regra vale tambem para a parte relativa aos centavos.
const
  unidade      : array [1..9] of string=('UM',     'DOIS',     'TRÊS',      'QUATRO',       'CINCO',      'SEIS',       'SETE',       'OITO',       'NOVE');
  dezenacheia  : array [1..9] of string=('ONZE',   'DOZE',     'TREZE',     'QUATORZE',     'QUINZE',     'DEZESSEIS',  'DEZESSETE',  'DEZOITO',    'DEZENOVE');
  dezena       : array [1..9] of string=('DEZ',    'VINTE',    'TRINTA',    'QUARENTA',     'CINQUENTA',  'SESSENTA',   'SETENTA',    'OITENTA',    'NOVENTA');
  centena      : array [1..9] of string=('CEM',    'DUZENTOS', 'TREZENTOS', 'QUATROCENTOS', 'QUINHENTOS', 'SEISCENTOS', 'SETECENTOS', 'OITOCENTOS', 'NOVECENTOS');
  centenacheia : array [1..9] of string=('CENTO',  'DUZENTOS', 'TREZENTOS', 'QUATROCENTOS', 'QUINHENTOS', 'SEISCENTOS', 'SETECENTOS', 'OITOCENTOS', 'NOVECENTOS');
  milhar       = 'MIL';
  milhao       : array [1..2] of string=('MILHÃO', 'MILHÕES');
  bilhao       : array [1..2] of string=('BILHÃO', 'BILHÕES');

var TEMP,                  // Armazena a montagem do trecho analisado parte do extenso
    Sufixo,                // Armazena a descricao do trecho analisado
    ValAux,                // Armazena o trecho a ser analisado
    ValAuxAnt,             // Armazena o valor anterior de ValAux
    ValorExtenso : string; // Armazena a descricao por extenso do valor
    Item : integer;        // Armazena a sequencia do trecho que esta sendo analisado

begin
  ValorExtenso := '';
  ValAuxAnt := '000';
  Item := 1;
  TEMP := '';
  // Copia da string o valor dos centavos para iniciar o processo
  ValAux := LimpaCodigo(Right(DADO, 2), 3);
  // Retira do numero a parte relativa aos centavos
  DADO := Copy (DADO, 1, Length(DADO)-3);

  while ValAux <> '' do
    begin
      // Avalia a centena
      //  Se a dezena + unidade forem maior que  0 e a centena maior que 0,
      //  pego a posicao equivalente a cetena no vetor centena cheia
      if ((StrToInt(Copy(ValAux, 2, 2)) > 0) and  (StrToInt(ValAux[1]) > 0 )) then
        TEMP := CentenaCheia[StrToInt(ValAux[1])] + ' E '
      else
        // Se a centena for maior que 0,
        // pego a posicao equivalente a centena no vetor da centena
        if (StrToInt(ValAux[1]) > 0 ) then
          TEMP := Centena[StrToInt(ValAux[1])];

      // Avalia a dezena
      // Se a unidade for maior que zero e a dezena igual a um
      // pego a posicao equivalente a unidade do vetor dezena cheia
      if ((StrToInt(Copy(ValAux, 3, 1)) > 0)  and (ValAux[2] = '1')) then
        TEMP := TEMP + DezenaCheia[StrToInt(ValAux[3])]
      else
        begin
          // Se a dezena for maior que 1,
          // pego a posicao equivalente a dezena no vetor dezena
          if (StrToInt(Copy(ValAux, 2, 1)) > 1) then
            TEMP := TEMP + Dezena[StrToInt(ValAux[2])]
          else
            // Se a dezena for igual a 1 e a unidade igual a 0 ( numero 10 ),
            // pego a posicao 10 do vetor de unidade
            if (StrToInt(Copy(ValAux, 2, 1)) = 1) and (ValAux[3] = '0') then
              TEMP := TEMP + Dezena[StrToInt(ValAux[2])];

          // Se a dezena for diferente de 1 e a unidade diferente de 0,
          // pego a posicao equivalente a unidade no vetor unidade
          if (ValAux[3] <> '0') then
             if (StrToInt(Copy(ValAux, 2, 1)) > 1) then
               TEMP := TEMP + ' E ' + Unidade[StrToInt(ValAux[3])]
             else
               if (StrToInt(Copy(ValAux, 2, 1)) = 0) then
                 TEMP := TEMP + Unidade[StrToInt(ValAux[3])]

        end;

      Case Item of
        // Passo do "centavos"
        1: begin
             // Se os "centavos" forem maior que 1
             // pego a descricao no plural
             if StrToInt (ValAux) > 1 then
               Sufixo := ' ' + UPPER(DecimalPlural)
             else
               // Se os "centavos" forem igual a 1
               // pego a descricao no singular
               if StrToInt (ValAux) = 1 then
                 Sufixo := ' ' + UPPER(DecimalSingular);
           end;
        // Passo da "centena"
        2: begin
             // Se a "centena" for maior que 1
             // pego a descricao no plural
             if (StrToInt (ValAux) > 1)  then
               Sufixo := ' ' + UPPER(MoedaPlural)
             else
               // Se a "centena" for menor ou igual a 1 e ainda existirem
               // valores a serem convertidos, pego a descricao no plutal
               // senao no singular
               if ((StrToInt (ValAux) <= 1) and (LENGTH(DADO) > 0)) then
                 Sufixo := ' ' + UPPER(MoedaPlural)
               else
                 if (LENGTH(DADO) > 0) then
                   Sufixo := ' ' + UPPER(MoedaSingular);
           end;
        // Passo do "milhar"
        3: begin
             // Se o "milhar" for maior ou igual a um
             // pego a descricao do "milhar" (que e igual para todos)
             if (StrToInt (ValAux) >= 1)  then
               Sufixo := ' ' + Milhar;
           end;
        // Passo do "milhao"
        4: begin
             // Se o "milhao" for maior que 1
             // pego a descricao no plural
             if (StrToInt (ValAux) > 1)  then
               Sufixo := ' ' + Milhao[2]
             else
               // Se o "milhao" for igual a 1
               // pego a descricao no singular
               if (StrToInt (ValAux) = 1)  then
                 Sufixo := ' ' + Milhao[1]
           end;
        // Passo do "bilhao"
        5: begin
             // Se o "bilhao" for maior que 1
             // pego a descricao no plural
             if (StrToInt (ValAux) > 1)  then
               Sufixo := ' ' + Bilhao[2]
             else
               // Se o "bilhao" for igual a 1
               // pego a descricao no singular
               if (StrToInt (ValAux) = 1)  then
                 Sufixo := ' ' + Bilhao[1]
           end;
      end;

      // Se o valor do grupo anterior analisado for diferente de zero e
      // ainda faltar parte a ser analisada OU a parte atual maior que zero
      // insiro a conjuncao "e"
      if (StrToInt(ValAuxAnt) > 0) and
         ((LENGTH(DADO) > 0) or (StrToInt(ValAux) > 0)) then
        Sufixo := Sufixo + ' E ';

      // Anexa a parte analisada com o sufixo no valor por extenso
      ValorExtenso := TEMP + Sufixo + ValorExtenso ;
      ValAuxAnt := ValAux;
      ValAux := '';
      TEMP   := '';
      Sufixo := '';

      // Incrementa o trecho a ser analisado
      Inc(Item);
      // Verifica o tamanho do numero que resta ser analisado se e maior que 3
      if Length(DADO) > 3 then
        begin
          // Copia os 3 ultimos digitos da direita para analisar
          ValAux := LimpaCodigo(Right(DADO, 3), 3);
          // Retira os 3 últimos digitos da direita
          DADO := Copy (DADO, 1, Length(DADO)-4);
        end
      else
        // Verifica se do numero que resta ser analisado se e maior ou igual a 1
        if Length(DADO) >= 1 then
          begin
            // Copia a quantidade de numeros que falta analisar
            ValAux := LimpaCodigo(DADO, 3);
            // Limpa o que resta ser analisado do numero
            DADO := '';
          end;
    end;

  // Verifica o tamanho da string e preenche com * - até o tamanho de 255
  if length(ValorExtenso) < 255 then
    begin
      ValorExtenso := ValorExtenso + ' ';
      while length(ValorExtenso) < 255 do
        ValorExtenso := ValorExtenso + '* - ';
    end;

  // Retorna a string com o valor por extenso
  PorExtenso := ValorExtenso;
end;


function FormaValor(VALOR: real; COMPR, CASAS: byte): string;
var
  TempStr: string;
begin
  Str(VALOR: COMPR: CASAS, TempStr);
  FormaValor := TempStr;
end; { FormaValor }

function TiraPonto(VALOR: string): string;
var
  TEMP: string;
  i: byte;
begin
  TEMP := VALOR;
  i := pos('.', TEMP);
  while i > 0 do
  begin
    Delete(TEMP, i, 1);
    i := pos('.', TEMP);
  end;
  TiraPonto := TEMP;
end;

function RetiraCaracter(DADO: string; Antigo: char): string;
var texto: string;
begin
  texto := dado;
  While Pos(Antigo, texto) > 0 do
     begin
        texto := Copy(texto, 1, Pos(Antigo, texto) - 1) + Copy(texto, Pos(Antigo, texto) + 1, Length(texto) - Pos(Antigo, texto));
     end;
  RetiraCaracter := texto;
end; { RetiraCaracter }

function TrocaCaracter(DADO: string; Antigo, Novo: char): string;
begin
  While Pos(Antigo, DADO) > 0 do
     DADO := Copy(DADO, 1, Pos(Antigo, DADO) - 1) + Novo +
                      Copy(DADO, Pos(Antigo, DADO) + 1, Length(DADO) - Pos(Antigo, DADO));
  TrocaCaracter := DADO;
end; { TrocaCaracter }

function TiraAspas(DADO: string; Antigo, Novo: char): string;
begin
  While Pos(Antigo, DADO) > 0 do
     DADO := Copy(DADO, 1, Pos(Antigo, DADO) - 1) + Novo + Novo +
                      Copy(DADO, Pos(Antigo, DADO) + 1, Length(DADO) - Pos(Antigo, DADO));
   TiraAspas := DADO;
end; { TrocaCaracter }


function LimpaMoeda(Valor, Moeda: string): string;
var resultado: string;
begin
  if Moeda = 'R' then
    Resultado := RetiraCaracter(Valor, '.');
  if Moeda = 'D' then
    Resultado := RetiraCaracter(Valor, ',');
  if Moeda = 'E' then
    Resultado := RetiraCaracter(Valor, '.');
  LimpaMoeda := Resultado;
end; { LimpaMoeda }


function funcObtemNovoCodigo(pDB: TIBDatabase; psNomeTabela, psNomeCampo: string): string;
var ibsql: TIBSQL;
  ibquery: TIBQuery;
begin
  result := '';
  if not pDB.Connected then exit;

  try
    ibquery := TIBQuery.Create(Application);
    ibquery.Database := pDB;
    if ibquery.Transaction.InTransaction then
      ibquery.Transaction.Commit;
    ibquery.Transaction.StartTransaction;
    ibquery.SQL.Text := 'SELECT MAX(' + psNomeCampo + ') FROM ' + psNomeTabela;
    try
      ibquery.Open;
      result := FormaCodigo(ibquery.Fields[0].AsInteger + 1, 6);
      ibquery.Transaction.Commit;
    except
      ibquery.Transaction.Rollback;
      result := '';
    end; // except
  finally
    //ibquery.Free;
    FreeAndNil(ibquery);
  end; // finally

  if result = '' then exit;

  try
    ibsql := TIBSQL.Create(Application);
    ibsql.Database := pDB;
    ibsql.Transaction.StartTransaction;
    try
      ibsql.SQL.Text := 'INSERT INTO ' + psNomeTabela + ' (' + psNomeCampo + ') VALUES (:' + psNomeCampo + ')';
      ibsql.Prepare;
      ibsql.ParamByName(psNomeCampo).AsString := result;
      ibsql.ExecQuery;
      ibsql.Transaction.Commit;
    except on E: EDatabaseError do begin
        ibsql.Transaction.Rollback;
        result := '';
//            Application.MessageBox('Ocorreu o seguinte erro ao gerar código para o campo '+psNomeCampo+' da tabela '+psNomeTabela+' : '+E.Message , Application.Title, [smbcancel],smsWarning);
      end;
    end; // except
  finally
    //ibsql.Free;
    FreeAndNil(ibsql);
  end; // finally
end; {funcObtemNovoCodigo}


function funcDelete(pDB: TIBDatabase; psNomeTabela, psClausulaWHere: string): boolean;
var ibsql: TIBSQL;
begin
  result := pDB.Connected;
  if not result then exit;
  try
    ibsql := TIBSQL.Create(Application);
    ibsql.Database := pDB;
    if ibsql.Transaction.InTransaction then
      ibsql.Transaction.Rollback;
    ibsql.Transaction.StartTransaction;
    try
      ibsql.SQL.Text := 'DELETE FROM ' + psNomeTabela + ' ' + psClausulaWhere;
      ibsql.ExecQuery;
      ibsql.Transaction.Commit;
      result := true;
    except on E: EDatabaseError do begin
        ibsql.Transaction.RollbackRetaining;
       // MessageBox('Erro ao excluir registro de' + psNomeTabela + ' - ' + E.Message, mtError, [mbOK], 0);
        result := false;
      end;
    end; // except
  finally
    //ibsql.Free;
    FreeAndNil(ibsql);
  end; // finally
end; {funcDelete}


function funcValidaData(psData: string): boolean;
var dtData: TDateTime;
begin
  try
    dtData := StrToDate(psData);
    result := true;
  except
    result := false;
  end;
end;

function funcValidaInteiro(psNum: string): boolean;
var i: integer;
begin
  try
    i := StrToInt(psNum);
    result := true;
  except
    result := false;
  end; // except
end;
{função para retirar o 'ponto' em uma string }

function RetiraVirgula(valor: string): string;
var i: integer;
begin
  result := '';
  for i := 1 to length(valor) do
    if valor[i] = '.' then result := result + ''
    else result := result + valor[i];
end;

function TeclaValida(Key: word): boolean;
var Resultado: boolean;
begin
  Resultado := False;
  case key of
    91, // Iniciar
      4096, // ESC
      4097, // Tab
      4099, // Back Space
      4100, // Carriage Return
      4101, // Carriage Return - Num Pad
      4102, // Insert
      4103, // Delete
      4104, // Pause Break
      4112, // Home
      4113, // End
      4117, // Down Arrow
      4115, // Up Arrow
      4118, // Page Up
      4119, // Page Down
      4128, // Left Shift
      4129, // Ctrl Left
      4131, // Alt
      4132, // Caps Lock
      4133, // Num Lock
      4134, // Scroll Lock
      4144, // F1
      4145, // F2
      4146, // F3
      4147, // F4
      4148, // F5
      4149, // F6
      4150, // F7
      4151, // F8
      4152, // F9
      4153, // F10
      4154, // F11
      4155, // F12
      4181: // Pop-Up Menu
      Resultado := True;
  end;
  TeclaValida := Resultado;
end;

function TeclaValidaChar(Key: WideChar): boolean;
var Resultado: boolean;
begin
  Resultado := False;
  case key of
    #91, // Iniciar
      #4096, // ESC
      #4097, // Tab
      #4099, // Back Space
      #4100, // Carriage Return
      #4101, // Carriage Return - Num Pad
      #4102, // Insert
      #4103, // Delete
      #4104, // Pause Break
      #4112, // Home
      #4113, // End
      #4117, // Down Arrow
      #4115, // Up Arrow
      #4118, // Page Up
      #4119, // Page Down
      #4128, // Left Shift
      #4129, // Ctrl Left
      #4131, // Alt
      #4132, // Caps Lock
      #4133, // Num Lock
      #4134, // Scroll Lock
      #4144, // F1
      #4145, // F2
      #4146, // F3
      #4147, // F4
      #4148, // F5
      #4149, // F6
      #4150, // F7
      #4151, // F8
      #4152, // F9
      #4153, // F10
      #4154, // F11
      #4155, // F12
      #4181: // Pop-Up Menu
      Resultado := True;
  end;
  TeclaValidaChar := Resultado;
end;

procedure ImprimeArquivo(NomeArquivo: string; LerSequencial: boolean);
var MArqZPl, MArqSaida: TextFile;
  MLinha: string;
  Msaida: string;
  carregada: boolean;
  x: byte;
  produto: string;
begin
  MSaida := Copy(NomeArquivo, 1, Length(NomeArquivo) - 3) + 'PRN';
  if FileExists(NomeArquivo) then
  begin
       // Atribui valores para variaveis de merge
    AssignFile(MArqZpl, NomeArquivo);
       {I$} Reset(MArqZpl); {+I$}
    if IOResult = 0 then
    begin
            // Verifica se o arquivo será aberto para tratamento do Merge
      if LerSequencial then
      begin
        AssignFile(MArqSaida, MSaida);
                {I$} Rewrite(MArqSaida); {+I$}
        while not eof(MArqZpl) do
        begin
          ReadLn(MArqZPL, MLinha);
          MLinha := MergeDados(MLinha, 1);
          //MLinha := Filtra(MLinha);
          WriteLn(MArqSaida, MLinha);
        end;
        CloseFile(MArqSaida);
        CloseFile(MArqZpl);
//        CopyFile(pchar(NomeArquivo), pchar(MSaida), oksend);
         CopyFile( pchar(MSaida), pchar(PRINTSaida), oksend );
//        if not oksend then
//           begin
//              delay(2000); // LM - 14/10/2010 dá uma pausa para resolver problema de impressão USB
//              CopyFile(pchar(NomeArquivo), pchar(MSaida), oksend);
//              CopyFile( pchar(MSaida), pchar(PRINTSaida), oksend );
 //          end;
        delay(1000); // LM - 14/10/2010 dá uma pausa para resolver problema de impressão USB
      end
      else
        if prnplataforma = '0' then // Windows
           begin
              CopyFile(pchar(NomeArquivo), pchar(MSaida), oksend);
              if not oksend then
                 begin
                    delay(2000); // LM - 14/10/2010 dá uma pausa para resolver problema de impressão USB
 //                   CopyFile(pchar(NomeArquivo), pchar(MSaida), oksend);
                    CopyFile( pchar(MSaidaImpressao), pchar(PRINTSaida), oksend );
                 end;
              delay(1000); // LM - 14/10/2010 dá uma pausa para resolver problema de impressão USB
           end;
    end
    else
     // MessageDlg('Erro na Abertura do Arquivo "' + ExtractFileName(NomeArquivo) + '"',
      //  mtInformation, [mbOk], 0);
  end
  else
   // MessageDlg('Arquivo Máscara "' + ExtractFileName(NomeArquivo) + '" não Encontrado !!!',
    //  mtInformation, [mbOk], 0);
end;

//----------------------------------------------------------------------------\\
// Gera numero de serie para caixas

function NumeroCaixa: string;
var NrEstacao, NrAno, NrDiaAno, NrCaixa: string;
begin
  NrEstacao := verificaini(StartPath + ArqConfig, 'Coletiva', 'Estacao', 'XX', 'LER');
  NrAno := verificaini(StartPath + ArqConfig, 'Coletiva', 'Ano', 'XX', 'LER');
  NrDiaAno := verificaini(StartPath + ArqConfig, 'Coletiva', 'DiaAno', 'XXX', 'LER');
  NrCaixa := verificaini(StartPath + ArqConfig, 'Coletiva', 'Caixa', 'XXXXX', 'LER');

  if ((NrAno = Copy(DateToStr(Date), 10, 1)) and
    (NrDiaAno = IntToStr(DayOfTheYear(Date)))) then
    NrCaixa := FormaCodigo((StrToInt(NrCaixa) + 1), 5)
  else
  begin
    NrAno := Copy(DateToStr(Date), 10, 1);
    NrDiaAno := IntToStr(DayOfTheYear(Date));
    NrCaixa := '00001';
  end;

  //Atualiza os valores da caixa na configuração

  VerificaINI(StartPath + arqconfig, 'Coletiva', 'Ano', Copy(DateToStr(Date), 10, 1), 'ESCREVER');
  VerificaINI(StartPath + arqconfig, 'Coletiva', 'DiaAno', IntToStr(DayOfTheYear(Date)), 'ESCREVER');
  VerificaINI(StartPath + arqconfig, 'Coletiva', 'Caixa', NrCaixa, 'ESCREVER');

  NumeroCaixa := NrEstacao + NrAno + NRDiaAno + NrCaixa;
end;

//==============================================================================
function GeraNumeroSerie(xinicial: string; xfinal: string; xproduto: string; xitem: String; xnf: string; xnfserie: string; xinvoice : string; xpedido: string; xqtd: integer; xlote : String; xtransf : String): Boolean;
var gravado, seq, totalok: integer;
  NumeroInicio: array[1..20] of integer;
  Inicio, Fim,
    Sequencia: string;
  Alterado: boolean;
  Qry: TIBQuery;
// Verifica quantos numeros de série foram incluidos   
function QtdCadastrada: integer;
var
   q : TIBQuery;
   wsql : String;
begin
  q := TIBQuery.Create(nil); result := 0;
  with Q do
  begin
    wsql := 'SELECT COUNT(PRODUTO) AS QTD FROM t_serie_nf WHERE ';
    wsql := wsql + 'PRODUTO=' + #39 + xproduto + #39 + ' AND ';
    wsql := wsql +  '( ';
    wsql := wsql +  'INVOICE=' + #39 + xinvoice + #39 + ' OR ';
    wsql := wsql +  'NF=' + #39 + xnf + #39;
    wsql := wsql + ' ) ';
    wsql := wsql + ' AND PEDIDO=' + #39 + xpedido + #39 + 'AND ITEM=' + #39 + xitem + #39;
    Database := DM_Config.IBDB; close;
    SQL.Clear;
    SQL.Text := wsql;

    {
    SQl.text := 'SELECT COUNT(PRODUTO) AS QTD FROM t_serie_nf WHERE ' +
      'PRODUTO=' + #39 + xproduto + #39 + ' AND ' +
      'INVOICE=' + #39 + xinvoice + #39 + ' OR ' +
      'NF=' + #39 + xnf + #39 + ' AND ' +
      'PEDIDO=' + #39 + xpedido + #39 + 'AND ITEM=' + #39 + xitem + #39;
    }
    Open;
    result := q.FieldByName('qtd').Asinteger;
    Free;
  end;
end;


begin
  Qry := TIBQuery.Create(nil); result := true;
  Qry.database := DM_Config.IBDB;
  { zera os arrays }
  for seq := 1 to 20 do
    NumeroInicio[seq] := 0;

  Inicio := PadR(xinicial, 20);
  Fim := PadR(xfinal, 20);

  for seq := 1 to 20 do
    NumeroInicio[seq] := ord(Inicio[seq]);

     // Gera o primeiro número de série
  if (QtdCadastrada) < xqtd then
  begin
    try
      with Qry do
      begin
        close;              
        SQL.text := 'insert into t_serie_nf (PRODUTO, SERIE, NF,INVOICE, PEDIDO, ITEM, NF_SERIE, LOTE, TRANSFORMACAO) values ' +
          '(' + #39 + xproduto + #39 + ', ' +
          #39 + alltrim(Inicio) + #39 + ', ' +
          #39 + xnf + #39 + ', ' +
          #39 + xinvoice + #39 + ', ' +
          #39 + xpedido + #39 + ', ' + #39 + xitem + #39 +',' + #39 + xnfserie + #39 + ',' + #39 + xlote + #39 + ','+ #39 + xtransf + #39 +')';
        ExecSQL;
      end;
    except result := false; end;
  end;

  while Sequencia <> Fim do
  begin
    Alterado := False;
    for seq := 20 downto 1 do
    begin
      if (not Alterado) then
        if NumeroInicio[seq] <> 32 then
        begin
          Inc(NumeroInicio[seq]);
          if (((NumeroInicio[seq] >= 48) and (NumeroInicio[seq] <= 57)) or
            ((NumeroInicio[seq] >= 65) and (NumeroInicio[seq] <= 90)) or
            ((NumeroInicio[seq] >= 97) and (NumeroInicio[seq] <= 122))) then
            Alterado := True
          else
            case NumeroInicio[seq] of
              58: NumeroInicio[seq] := 48;
              91: NumeroInicio[seq] := 65;
              123: NumeroInicio[seq] := 97;
            end;
        end;
    end;
    Sequencia := '';
    for seq := 1 to 20 do
      Sequencia := Sequencia + CHR(NumeroInicio[seq]);
    Sequencia := PadR(Sequencia, 20);
    if (QtdCadastrada) < xqtd then
    begin
      try
        with Qry do
        begin
        close;
        SQL.text := 'insert into t_serie_nf (PRODUTO, SERIE, NF, INVOICE, PEDIDO, ITEM, NF_SERIE, LOTE, TRANSFORMACAO) values ' +
          '(' + #39 + xproduto + #39 + ', ' +
          #39 + alltrim(Sequencia) + #39 + ', ' +
          #39 + xnf + #39 + ', ' +
          #39 + xinvoice + #39 + ', ' +
          #39 + xpedido + #39 + ', ' + #39 + xitem + #39 + ',' + #39 + xnfserie + #39 + ',' +  #39 + xlote +  #39 + ',' +  #39 + xtransf +  #39 +')';
        ExecSQL;
         {
          close;
          SQL.text := 'insert into t_serie_nf (PRODUTO, SERIE, INVOICE, PEDIDO, ITEM) values ' +
            '(' + #39 + xproduto + #39 + ', ' +
            #39 + alltrim(Sequencia) + #39 + ', ' +
            #39 + xnf + #39 + ', ' +
            #39 + xpedido + #39 + #39 + ', ' + xitem + #39 + ')';
          ExecSQL;
         } 
        end;
      except result := false; end;
    end;
  end;
end;






//==============================================================================

function GeraNumeroSerie2(xinicial: string; xfinal: string; xproduto: string; xnf: string; xpedido: string; xqtd: integer): Boolean;
var gravado, seq, totalok: integer;
  NumeroInicio: array[1..20] of integer;
  Inicio, Fim,
    Sequencia: string;
  Alterado: boolean;
  Qry: TIBQuery;
// Verifica quantos numeros de série foram incluidos
function QtdCadastrada: integer;
var q: TIBQuery;
begin
  q := TIBQuery.Create(nil); result := 0;
  with Q do
  begin
    Database := DM_Config.IBDB; close;
    SQl.text := 'SELECT COUNT(PRODUTO) AS QTD FROM t_serie_nf WHERE ' +
      'PRODUTO=' + #39 + xproduto + #39 + ' AND ' +
      'NF=' + #39 + xnf + #39 + ' AND ' +
      'PEDIDO=' + #39 + xpedido + #39; Open;
    result := q.FieldByName('qtd').Asinteger;
    Free;
  end;
end;


begin
  Qry := TIBQuery.Create(nil); result := true;
  Qry.database := DM_Config.IBDB;
  { zera os arrays }
  for seq := 1 to 20 do
    NumeroInicio[seq] := 0;

  Inicio := PadR(xinicial, 20);
  Fim := PadR(xfinal, 20);

  for seq := 1 to 20 do
    NumeroInicio[seq] := ord(Inicio[seq]);

     // Gera o primeiro número de série
  if (QtdCadastrada) < xqtd then
  begin
    try
      with Qry do
      begin
        close;
        SQL.text := 'insert into t_serie_nf (PRODUTO, SERIE, NF, PEDIDO) values ' +
          '(' + #39 + xproduto + #39 + ', ' +
          #39 + alltrim(Inicio) + #39 + ', ' +
          #39 + xnf + #39 + ', ' +
          #39 + xpedido + #39 + ')';
        ExecSQL;
      end;
    except result := false; end;
  end;

  while Sequencia <> Fim do
  begin
    Alterado := False;
    for seq := 20 downto 1 do
    begin
      if (not Alterado) then
        if NumeroInicio[seq] <> 32 then
        begin
          Inc(NumeroInicio[seq]);
          if (((NumeroInicio[seq] >= 48) and (NumeroInicio[seq] <= 57)) or
            ((NumeroInicio[seq] >= 65) and (NumeroInicio[seq] <= 90)) or
            ((NumeroInicio[seq] >= 97) and (NumeroInicio[seq] <= 122))) then
            Alterado := True
          else
            case NumeroInicio[seq] of
              58: NumeroInicio[seq] := 48;
              91: NumeroInicio[seq] := 65;
              123: NumeroInicio[seq] := 97;
            end;
        end;
    end;
    Sequencia := '';
    for seq := 1 to 20 do
      Sequencia := Sequencia + CHR(NumeroInicio[seq]);
    Sequencia := PadR(Sequencia, 20);
    if (QtdCadastrada) < xqtd then
    begin
      try
        with Qry do
        begin
          close;
          SQL.text := 'insert into t_serie_nf (PRODUTO, SERIE, NF, PEDIDO) values ' +
            '(' + #39 + xproduto + #39 + ', ' +
            #39 + alltrim(Sequencia) + #39 + ', ' +
            #39 + xnf + #39 + ', ' +
            #39 + xpedido + #39 + ')';
          ExecSQL;
        end;
      except result := false; end;
    end;
  end;
end;





//==============================================================================
function Decimais(Valor: string): integer;
var Resultado,
    Casas,
    Indice     : integer;
    DADO       : string;
begin
  DADO := AllTrim(Valor);
  if (Pos(',', DADO) = 0) and (Pos('.', DADO) = 0) then
    Resultado := 0
  else
    begin
      Indice := Length(DADO);
      Casas  := 0;
      while Indice > 0 do
        begin
          if ((DADO[indice] <> ',') and
              (DADO[indice] <> '.')) then
            begin
              Inc(Casas);
              Dec(Indice);
            end
          else
            begin
              Indice    := 0;
              Resultado := Casas;
            end
        end;
    end;
   Decimais := Resultado;
end;

//function Arredonda4(Valor : Real; CasasDecimais : integer):Real;
//var AuxValor   : Real;
//    AuxParte, Arredondamento,
//    ParteInteira,  ParteDecimal,
//    AuxDecimal,    Indice,
//    Potencia   : Integer;
//
//begin
//  // Calcula qual a base de calculo para o Arredondamento
//  Potencia := 1;
//  for Indice := 1 to CasasDecimais + 2 do
//     Potencia := 10 * Potencia;
//  // Deixa somente a quantidade decimal correspondente à Potencia desejada
//  AuxValor := (Valor * Potencia);
//  AuxValor := TRUNC(AuxValor);
//  AuxValor := (AuxValor / Potencia);
//
//  // Verifica quantidade de casas decimais que restaram
//  AuxDecimal := Decimais(FloatToStr(AuxValor));
//  // Verifica se existem casas decimais a serem arredondadas
//  if AuxDecimal > CasasDecimais  then
//    begin
//      Potencia := TRUNC(Potencia / 10);
//      // Separa parte inteira da parte decimal
//      ParteInteira := TRUNC(AuxValor);
//      AuxValor     := (AuxValor - ParteInteira);
//      AuxValor     := (AuxValor * Potencia);
//
////      ParteDecimal := StrToInt(LimpaCodigo(Copy(FormaValor(AuxValor, CasasDecimais+1, 0), 1 , CasasDecimais+1), CasasDecimais+1));
//      ParteDecimal := StrToInt(LimpaCodigo(Copy(PadR(FloatToStr(AuxValor), 10), 1 , CasasDecimais+1), CasasDecimais+1));
//
//      // Verifica se o arredondamento será necessário
//      Arredondamento := 0;
//      if StrToInt(Copy (LimpaCodigo(IntToStr(ParteDecimal), CasasDecimais+1), CasasDecimais+1, 1)) >= 5 then
//        Arredondamento := 1;
//      // Monta novamente o número com as casas arredondadas
//      ParteDecimal := TRUNC(ParteDecimal / 10) + Arredondamento;
//      AuxValor  := ParteInteira + (ParteDecimal / (Potencia/10));
//    end;
//
//    //Retorna o valor arredondado
//  Arredonda := AuxValor;
//end;

//function Arredonda(Valor : Real; CasasDecimais : integer):Real;
//var
//    Arredondamento,
//    Posicao,
//    AuxDecimal,
//    Indice         : integer;
//    ParteInteira,
//    ParteDecimal,
//    ValorStr       : string;
//    Potencia       : Extended;
//    VlNegativo     : boolean;
//begin
//  // Verifica se o valora a ser arredondado é negativo
//  VlNegativo := (Valor < 0.0);
//  if VlNegativo then
//     Valor := Valor * (-1);
//
//  // Calcula qual a base de calculo para o Arredondamento
//  Potencia := 1;
//  for Indice := 1 to CasasDecimais + 1 do
//     Potencia := 10 * Potencia;
//
//  // Transforma o valor em string
//  ValorStr := AllTrim(FloatToStrF(Valor, ffNumber, 15, 6));
//  if SysUtils.DecimalSeparator = ',' then
//    ValorStr := RetiraCaracter(ValorStr, '.')
//  else
//    ValorStr := RetiraCaracter(ValorStr, ',');
//
//  // Verifica quantidade de casas decimais que restaram
//  AuxDecimal := Decimais(ValorStr);
//
//  // Verifica a posicao do caracter decimal
//  Posicao := Pos(SysUtils.DecimalSeparator, ValorStr);
//
//  // Separa as partes decimais e inteira do valor
//  if Posicao > 0 then
//    // Verifica se existem casas decimais a serem arredondadas
//    if AuxDecimal > CasasDecimais  then
//      begin
//        Potencia := INT(Potencia / 10);
//        // Separa parte inteira da parte decimal
//        ParteInteira := Copy (ValorStr, 1, Posicao-1);
//        ParteDecimal := Copy (ValorStr, Posicao+1, length(ValorStr)-Posicao);
//
//        // Verifica se o arredondamento será necessário
//        Arredondamento := 0;
//        if StrToInt(Copy (ParteDecimal, CasasDecimais+1, 1)) >= 5 then
//          Arredondamento := 1;
//        // Monta novamente o número com as casas arredondadas
//        ParteDecimal := LimpaCodigo(IntToStr(StrToInt(Copy(ParteDecimal, 1, CasasDecimais)) + Arredondamento), CasasDecimais);
//        if VlNegativo then
//          ValorStr := FloatToStrF((-1) * (StrToInt(ParteInteira) + (StrToInt(ParteDecimal)/Potencia)), ffnumber, 12, CasasDecimais)
//        else
//          ValorStr := FloatToStrF(StrToInt(ParteInteira) + (StrToInt(ParteDecimal)/Potencia), ffnumber, 12, CasasDecimais);
//        if SysUtils.DecimalSeparator = ',' then
//          ValorStr := RetiraCaracter(ValorStr, '.')
//        else
//          ValorStr := RetiraCaracter(ValorStr, ',');
//      end;
//
//    //Retorna o valor arredondado
//  Arredonda := StrToFloat(ValorStr);
//end;


//function Arredonda(Valor : Real; CasasDecimais : integer):Real;
//var
//    Arredondamento,
//    Posicao,
//    AuxDecimal,
//    Indice         : integer;
//    ParteInteira,
//    ParteDecimal,
//    ValorStr       : string;
//    Potencia       : Extended;
//    VlNegativo     : boolean;
//begin
//  // Verifica se o valora a ser arredondado é negativo
//  VlNegativo := (Valor < 0.0);
//  if VlNegativo then
//    Valor := Valor * (-1);
//  // Calcula qual a base de calculo para o Arredondamento
//  Potencia := 1;
//  for Indice := 1 to CasasDecimais + 1 do
//     Potencia := 10 * Potencia;
//
//  // Transforma o valor em string
//  ValorStr := AllTrim(FloatToStrF(Valor, ffNumber, 10, 3));
//  if SysUtils.DecimalSeparator = ',' then
//    ValorStr := RetiraCaracter(ValorStr, '.')
//  else
//    ValorStr := RetiraCaracter(ValorStr, ',');
//
//  // Verifica quantidade de casas decimais que restaram
//  AuxDecimal := Decimais(ValorStr);
//
//  // Verifica a posicao do caracter decimal
//  Posicao := Pos(SysUtils.DecimalSeparator, ValorStr);
//
//  // Separa as partes decimais e inteira do valor
//  if Posicao > 0 then
//    // Verifica se existem casas decimais a serem arredondadas
//    if AuxDecimal > CasasDecimais  then
//      begin
//        Potencia := INT(Potencia / 10);
//        // Separa parte inteira da parte decimal
//        ParteInteira := Copy (ValorStr, 1, Posicao-1);
//        ParteDecimal := Copy (ValorStr, Posicao+1, length(ValorStr)-Posicao);
//
//        // Verifica se o arredondamento será necessário
//        Arredondamento := 0;
//        if StrToInt(Copy (ParteDecimal, CasasDecimais+1, 1)) >= 5 then
//          Arredondamento := 1;
//        // Monta novamente o número com as casas arredondadas
//        ParteDecimal := LimpaCodigo(IntToStr(StrToInt(Copy(ParteDecimal, 1, CasasDecimais)) + Arredondamento), CasasDecimais);
//
//        if VlNegativo then
//          ValorStr := FloatToStrF((-1) * (StrToInt(ParteInteira) + (StrToInt(ParteDecimal)/Potencia)), ffnumber, 12, CasasDecimais)
//        else
//          ValorStr     := FloatToStrF(StrToInt(ParteInteira) + (StrToInt(ParteDecimal)/Potencia), ffnumber, 12, CasasDecimais);
//
//        if SysUtils.DecimalSeparator = ',' then
//          ValorStr := RetiraCaracter(ValorStr, '.')
//        else
//          ValorStr := RetiraCaracter(ValorStr, ',');
//      end;
//
//    //Retorna o valor arredondado
//  Arredonda := StrToFloat(ValorStr);
//end;

function Arredonda(Valor : Real; CasasDecimais : integer):Real;
var
    Arredondamento,
    Posicao,
    AuxDecimal,
    Indice         : integer;
    ParteInteira,
    ParteDecimal,
    ValorAux,
    ValorStr       : string;
    Potencia       : Extended;
    VlNegativo     : boolean;
begin
  // Verifica se o valora a ser arredondado é negativo
  VlNegativo := (Valor < 0.0);
  if VlNegativo then
    Valor := Valor * (-1);
  // Calcula qual a base de calculo para o Arredondamento
  Potencia := 1;
  for Indice := 1 to CasasDecimais + 1 do
     Potencia := 10 * Potencia;

  // Transforma o valor em string
  //ValorStr := AllTrim(FloatToStrF(Valor, ffNumber, 10, 3));
  Valor := Valor * Potencia;
  ValorStr := FloatToStr(Valor);
//  if Pos(SysUtils.DecimalSeparator, ValorStr) > 0 then
//    ValorAux := Copy (ValorStr, 1, Pos(SysUtils.DecimalSeparator, ValorStr)-1)
//  else
//    ValorAux := ValorStr;
//  Valor := StrToInt(ValorAux)/Potencia;
//  ValorStr := AllTrim(FloatToStrF(Valor, ffNumber, 10, CasasDecimais+1));
//
//  if SysUtils.DecimalSeparator = ',' then
//    ValorStr := RetiraCaracter(ValorStr, '.')
//  else
//    ValorStr := RetiraCaracter(ValorStr, ',');
//
//  // Verifica quantidade de casas decimais que restaram
//  AuxDecimal := Decimais(ValorStr);
//
//  // Verifica a posicao do caracter decimal
//  Posicao := Pos(SysUtils.DecimalSeparator, ValorStr);

  // Separa as partes decimais e inteira do valor
  if Posicao > 0 then
    // Verifica se existem casas decimais a serem arredondadas
    if AuxDecimal > CasasDecimais  then
      begin
        Potencia := INT(Potencia / 10);
        // Separa parte inteira da parte decimal
        ParteInteira := Copy (ValorStr, 1, Posicao-1);
        ParteDecimal := Copy (ValorStr, Posicao+1, length(ValorStr)-Posicao);

        // Verifica se o arredondamento será necessário
        Arredondamento := 0;
        if StrToInt(Copy (ParteDecimal, CasasDecimais+1, 1)) >= 5 then
          Arredondamento := 1;
        // Monta novamente o número com as casas arredondadas
        ParteDecimal := LimpaCodigo(IntToStr(StrToInt(Copy(ParteDecimal, 1, CasasDecimais)) + Arredondamento), CasasDecimais);

        if VlNegativo then
          ValorStr := FloatToStrF((-1) * (StrToInt(ParteInteira) + (StrToInt(ParteDecimal)/Potencia)), ffnumber, 12, CasasDecimais)
        else
          ValorStr     := FloatToStrF(StrToInt(ParteInteira) + (StrToInt(ParteDecimal)/Potencia), ffnumber, 12, CasasDecimais);

//        if SysUtils.DecimalSeparator = ',' then
//          ValorStr := RetiraCaracter(ValorStr, '.')
//        else
//          ValorStr := RetiraCaracter(ValorStr, ',');
      end;

    //Retorna o valor arredondado
  Arredonda := StrToFloat(ValorStr);
end;



function DataExtenso (DataBase: string):string;
var
        TempStr, mes : string;
        dia, xmes, ano: Word;
        data:TdateTime;
begin
        data:= StrToDate(DataBase);
        DecodeDate(date,ano,xmes,dia);
        TempStr := 'Campinas, ';
        //  TempStr := TempStr + Copy (DataBase, 1, 2); // dia
        TempStr := TempStr + IntToStr(dia);
        TempStr := TempStr + ' de ';
        //  mes := Copy (DataBase, 4, 2); // mes
        //  mes:= xmes;
        //  case StrToInt(mes) of
        case xmes of
                1: TempStr := TempStr + 'Janeiro';
                2: TempStr := TempStr + 'Fevereiro';
                3: TempStr := TempStr + 'Março';
                4: TempStr := TempStr + 'Abril';
                5: TempStr := TempStr + 'Maio';
                6: TempStr := TempStr + 'Junho';
                7: TempStr := TempStr + 'Julho';
                8: TempStr := TempStr + 'Agosto';
                9: TempStr := TempStr + 'Setembro';
                10: TempStr := TempStr + 'Outubro';
                11: TempStr := TempStr + 'Novembro';
                12: TempStr := TempStr + 'Dezembro';
        end;
        TempStr := TempStr + ' de ';
        TempStr := TempStr + Copy (DataBase, 7, 4); // ano
        DataExtenso := TempStr;
end;     { DataExtenso }


function TiraMilhar (DADO: string): string;
var
        TEMP: string;
        i: byte;
begin
        TEMP := DADO;
        for i := Length (TEMP) downto 1 do
                if TEMP[i]= '.' then
                        Delete (TEMP, i, 1);
        TiraMilhar := TEMP;
end;

function Numero (campo : string) : boolean;
var
   code,
   n,
   i : integer;

   tmp,
   aux,
   aux2 : string;

   ok : boolean;
begin

   aux := campo;
   aux2 := aux;
   tmp := Limpa(aux);
   i := 0;
   while pos(',',aux) > 0 do
      begin
         delete(aux,pos(',',aux),1);
         i := i + 1;
      end;


   if i >= 2 then
      ok := false
   else if pos(',',aux2) = 1 then
      ok := false
   else
      begin
         val(tmp,n,code);
         if code = 0 then
            ok := true
         else
            ok := false;
      end;
   Numero := ok;
end;


function Limpa(campo :string):string;
var
  i : integer;
  tmp : string;
  ok : boolean;
begin
   ok := true;
   i := 0;
   tmp := campo;

   while ok do
      begin
         ok := false;
         for i:=1 to length(tmp) do
            begin
               if (tmp[i] = '.') or (tmp[i] = ',') then
                  begin
                     ok := true;
                     delete(tmp,i,1);
                  end;
            end;
      end;

    Limpa := tmp;

end;



function OnlyChar(campo : String) : boolean;{BY NOBOW}
var
   tmp : String;
   ok : boolean;
   i : integer;
   c : char;
begin
   ok := True;
   tmp := campo;
   if (tmp <> '') and (Length(tmp) > 0) then
      begin
         for i := 0 to Length(tmp) do
            begin
               c := tmp[i];
               if c in ['0'..'9'] then
              ok := False;
            end;
      end;
   OnlyChar := ok;
end;


function IsEmpty(campo : string) : boolean; {BY NOBOW}
var
   ok : boolean;
   tmp : string;
begin
   tmp := campo;
   if (tmp <> '') or (Length(tmp) > 0) then
      ok := False  // NÃO É UMA STRING VAZIA
   else
      ok := True;
   IsEmpty := ok   // É UMA STRING VAZIA.
end;

function OnlyNumberInteger(campo : String) : boolean;{BY NOBOW}
var
   tmp : String;
   ok : boolean;
   i : integer;
   c : char;
begin
   ok := True;
   tmp := campo;
   if (tmp <> '') and (Length(tmp) > 0) then
      begin
         for i := 1 to Length(tmp) do
            begin
               c := tmp[i];
               if not (c in ['0'..'9']) then
                 ok := False;
            end;
      end;
   OnlyNumberInteger := ok;
end;



function OnlyNumber(campo : String) : boolean;{BY NOBOW}
var
   tmp : String;
   ok : boolean;
   i : integer;
   c : char;
begin
   ok := True;
   tmp := campo;
   if (tmp <> '') and (Length(tmp) > 0) then
      begin
         for i := 1 to Length(tmp) do
            begin
               c := tmp[i];
               if (not (c in ['0'..'9'])) and (not (c in ['-',',','.'])) then
              ok := False;
            end;
      end;
   OnlyNumber := ok;
end;

//------------------------------------------------------------------------------
// Adicionado por Harley  9/8/2006
//------------------------------------------------------------------------------
Function ReplaceString(ToBeReplaced, ReplaceWith : string; TheString :string):string;
//
// Substitui, em uma cadeia de caracteres, todas as ocorrências
// de uma string por outra
//
// ToBeReplaced: String a ser substituida
// ReplaceWith : String Substituta
// TheString: Cadeia de strings
//
var
        Position: Integer;
        LenToBeReplaced: Integer;
        TempStr: String;
        TempSource: String;
begin
        LenToBeReplaced:=length(ToBeReplaced);
        TempSource:=TheString;
        TempStr:='';

        repeat
                position := pos(ToBeReplaced, TempSource);
        if (position <> 0) then
        begin
                TempStr := TempStr + copy(TempSource, 1, position-1); //Part before ToBeReplaced
                TempStr := TempStr + ReplaceWith; //Tack on replace with string
                TempSource := copy(TempSource, position+LenToBeReplaced, length(TempSource)); // Update what's left
        end
        else
        begin
                Tempstr := Tempstr + TempSource; // Tack on the rest of the string
        end;
        until (position = 0);
                Result:=Tempstr;
end;

//******************************************************************************
//Valida CNPJ (com pontuação)                                                  *
//Valida Inscrição estadual (não testado)                                      *
//Var Tipo = Sigla do estado da Inscrição ou CNPJ                              *
//******************************************************************************
Function Inscricao( Inscricao, Tipo : String ) : Boolean; Var

Contador  : ShortInt;
Casos     : ShortInt;
Digitos   : ShortInt;

Tabela_1  : String;
Tabela_2  : String;
Tabela_3  : String;

Base_1    : String;
Base_2    : String;
Base_3    : String;

Valor_1   : ShortInt;

Soma_1    : Integer;
Soma_2    : Integer;

Erro_1    : ShortInt;
Erro_2    : ShortInt;
Erro_3    : ShortInt;

Posicao_1 : string;
Posicao_2 : String;

Tabela    : String;
Rotina    : String;
Modulo    : ShortInt;
Peso      : String;

Digito    : ShortInt;

Resultado : String;
Retorno   : Boolean;
 
Begin

  Try



  Tabela_1 := ' ';
  Tabela_2 := ' ';
  Tabela_3 := ' ';

  {                                                                               }                                                                                                                 {                                                                                                }
  {         Valores possiveis para os digitos (j)                                 }
  {                                                                               }
  { 0 a 9 = Somente o digito indicado.                                            }
  {     N = Numeros 0 1 2 3 4 5 6 7 8 ou 9                                        }
  {     A = Numeros 1 2 3 4 5 6 7 8 ou 9                                          }
  {     B = Numeros 0 3 5 7 ou 8                                                  }
  {     C = Numeros 4 ou 7                                                        }
  {     D = Numeros 3 ou 4                                                        }
  {     E = Numeros 0 ou 8                                                        }
  {     F = Numeros 0 1 ou 5                                                      }
  {     G = Numeros 1 7 8 ou 9                                                    }
  {     H = Numeros 0 1 2 ou 3                                                    }
  {     I = Numeros 0 1 2 3 ou 4                                                  }
  {     J = Numeros 0 ou 9                                                        }
  {     K = Numeros 1 2 3 ou 9                                                    }
  {                                                                               }
  { ----------------------------------------------------------------------------- }
  {                                                                               }
  {         Valores possiveis para as rotinas (d) e (g)                           }
  {                                                                               }
  { A a E = Somente a Letra indicada.                                             }
  {     0 = B e D                                                                 }
  {     1 = C e E                                                                 }
  {     2 = A e E                                                                 }
  {                                                                               }
  { ----------------------------------------------------------------------------- }
  {                                                                               }
  {                                  C T  F R M  P  R M  P                        }
  {                                  A A  A O O  E  O O  E                        }
  {                                  S M  T T D  S  T D  S                        }
  {                                                                               }
  {                                  a b  c d e  f  g h  i  jjjjjjjjjjjjjj        }
  {                                  0000000001111111111222222222233333333        }
  {                                  1234567890123456789012345678901234567        }

  IF Tipo = 'AC'   Then Tabela_1 := '1.09.0.E.11.01. .  .  .     01NNNNNNX.14.00';
  IF Tipo = 'AC'   Then Tabela_2 := '2.13.0.E.11.02.E.11.01. 01NNNNNNNNNXY.13.14';
  IF Tipo = 'AL'   Then Tabela_1 := '1.09.0.0.11.01. .  .  .     24BNNNNNX.14.00';
  IF Tipo = 'AP'   Then Tabela_1 := '1.09.0.1.11.01. .  .  .     03NNNNNNX.14.00';
  IF Tipo = 'AP'   Then Tabela_2 := '2.09.1.1.11.01. .  .  .     03NNNNNNX.14.00';
  IF Tipo = 'AP'   Then Tabela_3 := '3.09.0.E.11.01. .  .  .     03NNNNNNX.14.00';
  IF Tipo = 'AM'   Then Tabela_1 := '1.09.0.E.11.01. .  .  .     0CNNNNNNX.14.00';
  IF Tipo = 'BA'   Then Tabela_1 := '1.08.0.E.10.02.E.10.03.      NNNNNNYX.14.13';
  IF Tipo = 'BA'   Then Tabela_2 := '2.08.0.E.11.02.E.11.03.      NNNNNNYX.14.13';
  IF Tipo = 'CE'   Then Tabela_1 := '1.09.0.E.11.01. .  .  .     0NNNNNNNX.14.13';
  IF Tipo = 'DF'   Then Tabela_1 := '1.13.0.E.11.02.E.11.01. 07DNNNNNNNNXY.13.14';
  IF Tipo = 'ES'   Then Tabela_1 := '1.09.0.E.11.01. .  .  .     0ENNNNNNX.14.00';
  IF Tipo = 'GO'   Then Tabela_1 := '1.09.1.E.11.01. .  .  .     1FNNNNNNX.14.00';
  IF Tipo = 'GO'   Then Tabela_2 := '2.09.0.E.11.01. .  .  .     1FNNNNNNX.14.00';
  IF Tipo = 'MA'   Then Tabela_1 := '1.09.0.E.11.01. .  .  .     12NNNNNNX.14.00';
  IF Tipo = 'MT'   Then Tabela_1 := '1.11.0.E.11.01. .  .  .   NNNNNNNNNNX.14.00';
  IF Tipo = 'MS'   Then Tabela_1 := '1.09.0.E.11.01. .  .  .     28NNNNNNX.14.00';
  IF Tipo = 'MG'   Then Tabela_1 := '1.13.0.2.10.10.E.11.11. NNNNNNNNNNNXY.13.14';
  IF Tipo = 'PA'   Then Tabela_1 := '1.09.0.E.11.01. .  .  .     15NNNNNNX.14.00';
  IF Tipo = 'PB'   Then Tabela_1 := '1.09.0.E.11.01. .  .  .     16NNNNNNX.14.00';
  IF Tipo = 'PR'   Then Tabela_1 := '1.10.0.E.11.09.E.11.08.    NNNNNNNNXY.13.14';
  IF Tipo = 'PE'   Then Tabela_1 := '1.14.1.E.11.07. .  .  .18ANNNNNNNNNNX.14.00';
  IF Tipo = 'PI'   Then Tabela_1 := '1.09.0.E.11.01. .  .  .     19NNNNNNX.14.00';
  IF Tipo = 'RJ'   Then Tabela_1 := '1.08.0.E.11.08. .  .  .      GNNNNNNX.14.00';
  IF Tipo = 'RN'   Then Tabela_1 := '1.09.0.0.11.01. .  .  .     20HNNNNNX.14.00';
  IF Tipo = 'RS'   Then Tabela_1 := '1.10.0.E.11.01. .  .  .    INNNNNNNNX.14.00';
  IF Tipo = 'RO'   Then Tabela_1 := '1.09.1.E.11.04. .  .  .     ANNNNNNNX.14.00';
  IF Tipo = 'RO'   Then Tabela_2 := '2.14.0.E.11.01. .  .  .NNNNNNNNNNNNNX.14.00';
  IF Tipo = 'RR'   Then Tabela_1 := '1.09.0.D.09.05. .  .  .     24NNNNNNX.14.00';
  IF Tipo = 'SC'   Then Tabela_1 := '1.09.0.E.11.01. .  .  .     NNNNNNNNX.14.00';
  IF Tipo = 'SP'   Then Tabela_1 := '1.12.0.D.11.12.D.11.13.  NNNNNNNNXNNY.11.14';
  IF Tipo = 'SP'   Then Tabela_2 := '2.12.0.D.11.12. .  .  .  NNNNNNNNXNNN.11.00';
  IF Tipo = 'SE'   Then Tabela_1 := '1.09.0.E.11.01. .  .  .     NNNNNNNNX.14.00';
  IF Tipo = 'TO'   Then Tabela_1 := '1.11.0.E.11.06. .  .  .   29JKNNNNNNX.14.00';
 
  IF Tipo = 'CNPJ' Then Tabela_1 := '1.14.0.E.11.21.E.11.22.NNNNNNNNNNNNXY.13.14';
  IF Tipo = 'CPF'  Then Tabela_1 := '1.11.0.E.11.31.E.11.32.   NNNNNNNNNXY.13.14';
 
  { Deixa somente os numeros }
 
  Base_1 := '';
 
  For Contador := 1 TO 30 Do IF Pos( Copy( Inscricao, Contador, 1 ), '0123456789' ) <> 0 Then Base_1 := Base_1 + Copy( Inscricao, Contador, 1 );

  { Repete 3x - 1 para cada caso possivel  }

  Casos  := 0;

  Erro_1 := 0;
  Erro_2 := 0;
  Erro_3 := 0;

  While Casos < 3 Do Begin
 
    Casos := Casos + 1;
 
    IF Casos = 1 Then Tabela := Tabela_1;
    IF Casos = 2 Then Erro_1 := Erro_3  ;
    IF Casos = 2 Then Tabela := Tabela_2;
    IF Casos = 3 Then Erro_2 := Erro_3  ;
    IF Casos = 3 Then Tabela := Tabela_3;
 
    Erro_3 := 0 ;
 
    IF Copy( Tabela, 1, 1 ) <> ' ' Then Begin
 
      { Verifica o Tamanho }

      IF Length( Trim( Base_1 ) ) <> ( StrToInt( Copy( Tabela,  3,  2 ) ) ) Then Erro_3 := 1;
 
      IF Erro_3 = 0 Then Begin
 
        { Ajusta o Tamanho }

        Base_2 := Copy( '              ' + Base_1, Length( '              ' + Base_1 ) - 13, 14 );
 
        { Compara com valores possivel para cada uma da 14 posições }

        Contador := 0 ;
 
        While ( Contador < 14 ) AND ( Erro_3 = 0 ) Do Begin

          Contador := Contador + 1;

          Posicao_1 := Copy( Copy( Tabela, 24, 14 ), Contador, 1 );
          Posicao_2 := Copy( Base_2                , Contador, 1 );
 
          IF ( Posicao_1  = ' '        ) AND (      Posicao_2                 <> ' ' ) Then Erro_3 := 1;
          IF ( Posicao_1  = 'N'        ) AND ( Pos( Posicao_2, '0123456789' )  =   0 ) Then Erro_3 := 1;
          IF ( Posicao_1  = 'A'        ) AND ( Pos( Posicao_2, '123456789'  )  =   0 ) Then Erro_3 := 1;
          IF ( Posicao_1  = 'B'        ) AND ( Pos( Posicao_2, '03578'      )  =   0 ) Then Erro_3 := 1;
          IF ( Posicao_1  = 'C'        ) AND ( Pos( Posicao_2, '47'         )  =   0 ) Then Erro_3 := 1;
          IF ( Posicao_1  = 'D'        ) AND ( Pos( Posicao_2, '34'         )  =   0 ) Then Erro_3 := 1;
          IF ( Posicao_1  = 'E'        ) AND ( Pos( Posicao_2, '08'         )  =   0 ) Then Erro_3 := 1;
          IF ( Posicao_1  = 'F'        ) AND ( Pos( Posicao_2, '015'        )  =   0 ) Then Erro_3 := 1;
          IF ( Posicao_1  = 'G'        ) AND ( Pos( Posicao_2, '1789'       )  =   0 ) Then Erro_3 := 1;
          IF ( Posicao_1  = 'H'        ) AND ( Pos( Posicao_2, '0123'       )  =   0 ) Then Erro_3 := 1;
          IF ( Posicao_1  = 'I'        ) AND ( Pos( Posicao_2, '01234'      )  =   0 ) Then Erro_3 := 1;
          IF ( Posicao_1  = 'J'        ) AND ( Pos( Posicao_2, '09'         )  =   0 ) Then Erro_3 := 1;
          IF ( Posicao_1  = 'K'        ) AND ( Pos( Posicao_2, '1239'       )  =   0 ) Then Erro_3 := 1;
          IF ( Posicao_1 <>  Posicao_2 ) AND ( Pos( Posicao_1, '0123456789' )  >   0 ) Then Erro_3 := 1;

        End;

        { Calcula os Digitos }

        Rotina  := ' ';
        Digitos := 000;
        Digito  := 000;

        While ( Digitos < 2 ) AND ( Erro_3 = 0 ) Do Begin

          Digitos := Digitos + 1;

          { Carrega peso }

          Peso := Copy( Tabela, 5 + ( Digitos * 8 ), 2 );

          IF Peso <> '  ' Then Begin

            Rotina :=           Copy( Tabela, 0 + ( Digitos * 8 ), 1 )  ;
            Modulo := StrToInt( Copy( Tabela, 2 + ( Digitos * 8 ), 2 ) );

            IF Peso = '01' Then Peso := '06.05.04.03.02.09.08.07.06.05.04.03.02.00';
            IF Peso = '02' Then Peso := '05.04.03.02.09.08.07.06.05.04.03.02.00.00';
            IF Peso = '03' Then Peso := '06.05.04.03.02.09.08.07.06.05.04.03.00.02';
            IF Peso = '04' Then Peso := '00.00.00.00.00.00.00.00.06.05.04.03.02.00';
            IF Peso = '05' Then Peso := '00.00.00.00.00.01.02.03.04.05.06.07.08.00';
            IF Peso = '06' Then Peso := '00.00.00.09.08.00.00.07.06.05.04.03.02.00';
            IF Peso = '07' Then Peso := '05.04.03.02.01.09.08.07.06.05.04.03.02.00';
            IF Peso = '08' Then Peso := '08.07.06.05.04.03.02.07.06.05.04.03.02.00';
            IF Peso = '09' Then Peso := '07.06.05.04.03.02.07.06.05.04.03.02.00.00';
            IF Peso = '10' Then Peso := '00.01.02.01.01.02.01.02.01.02.01.02.00.00';
            IF Peso = '11' Then Peso := '00.03.02.11.10.09.08.07.06.05.04.03.02.00';
            IF Peso = '12' Then Peso := '00.00.01.03.04.05.06.07.08.10.00.00.00.00';
            IF Peso = '13' Then Peso := '00.00.03.02.10.09.08.07.06.05.04.03.02.00';
            IF Peso = '21' Then Peso := '05.04.03.02.09.08.07.06.05.04.03.02.00.00';
            IF Peso = '22' Then Peso := '06.05.04.03.02.09.08.07.06.05.04.03.02.00';
            IF Peso = '31' Then Peso := '00.00.00.10.09.08.07.06.05.04.03.02.00.00';
            IF Peso = '32' Then Peso := '00.00.00.11.10.09.08.07.06.05.04.03.02.00';

            { Multiplica }

            Base_3 := Copy( ( '0000000000000000' + Trim( Base_2 ) ), Length( ( '0000000000000000' + Trim( Base_2 ) ) ) - 13, 14 );

            Soma_1 := 0;
            Soma_2 := 0;

            For Contador := 1 To 14 Do Begin

              Valor_1 := ( StrToInt( Copy( Base_3, Contador, 01 ) ) * StrToInt( Copy( Peso, Contador * 3 - 2, 2 ) ) );

              Soma_1  := Soma_1 + Valor_1;

              IF Valor_1 > 9 Then Valor_1 := Valor_1 - 9;

              Soma_2  := Soma_2 + Valor_1;

            End;

            { Ajusta valor da soma }

            IF Pos( Rotina, 'A2'  ) > 0 Then Soma_1 := Soma_2;
            IF Pos( Rotina, 'B0'  ) > 0 Then Soma_1 := Soma_1 * 10;
            IF Pos( Rotina, 'C1'  ) > 0 Then Soma_1 := Soma_1 + ( 5 + 4 * StrToInt( Copy( Tabela, 6, 1 ) ) );

            { Calcula o Digito }

            IF Pos( Rotina, 'D0'  ) > 0 Then Digito := Soma_1 Mod Modulo;
            IF Pos( Rotina, 'E12' ) > 0 Then Digito := Modulo - ( Soma_1 Mod Modulo);

            IF Digito < 10 Then Resultado := IntToStr( Digito );
            IF Digito = 10 Then Resultado := '0';
            IF Digito = 11 Then Resultado := Copy( Tabela, 6, 1 );

            { Verifica o Digito }

            IF ( Copy( Base_2, StrToInt( Copy( Tabela, 36 + ( Digitos * 3 ), 2 ) ), 1 ) <> Resultado ) Then Erro_3 := 1;

          End;

        End;

      End;

    End;

End;

  { Retorna o resultado da Verificação }

  Retorno := FALSE;

  IF ( Trim( Tabela_1 ) <> '' ) AND ( ERRO_1 = 0 ) Then Retorno := TRUE;
  IF ( Trim( Tabela_2 ) <> '' ) AND ( ERRO_2 = 0 ) Then Retorno := TRUE;
  IF ( Trim( Tabela_3 ) <> '' ) AND ( ERRO_3 = 0 ) Then Retorno := TRUE;

  IF Trim( Inscricao ) = 'ISENTO' Then Retorno := TRUE;
  if (Tipo = 'CNPJ') then
  begin
        if (length(Inscricao) <> 18) or
           (Copy(Inscricao,3,1) <> '.') or
           (Copy(Inscricao,7,1) <> '.') or
           (Copy(Inscricao,11,1) <> '/') or
           (Copy(Inscricao,16,1) <> '-') then
           Retorno := False;
  end;

  Result := Retorno;

  Except

  Result := False;
End;
end;


//------------------------------------------------------------------------------
// Valida Número de CPF USANDO PONTUAÇÃO
//------------------------------------------------------------------------------
function ValidarCPF(Numero: String): Boolean;
var i,j,k, Soma, Digito : Integer;
 Avaliar: String;
begin
 Result := false;
 if        ((length(Numero) <> 14) or
           (Copy(Numero,4,1) <> '.') or
           (Copy(Numero,8,1) <> '.') or
           (Copy(Numero,12,1) <> '-') ) then exit;

 delete(numero,4,1);
 delete(numero,7,1);
 delete(numero,10,1);
 Avaliar := Copy(Numero,1,Length(Numero)-2);
 for j := 1 to 2 do
 begin
   k      := 2;
   Soma  := 0;
   for i := Length(Avaliar) downto 1 do
   begin
     Soma := Soma + (Ord(Avaliar[i])-Ord('0'))*k;
     Inc(k);
     if (k > 9) and (Length(Avaliar)>=12) then k := 2;
   end;
   Digito := 11 - Soma mod 11;
   if Digito >= 10 then Digito := 0;
   Avaliar := Avaliar + Chr(Digito + Ord('0'));
    end;
 Result := Avaliar = Numero;
end;


//------------------------------------------------------------------------------
// Valida Número de CPF USANDO PONTUAÇÃO
//------------------------------------------------------------------------------
function LimpaCaracter(campo, caracter :String) :String;
var
  i : integer;
  tmp : string;
  ok : boolean;
begin
   ok := true;
   i := 0;
   tmp := campo;
   while ok do
      begin
         ok := false;
         for i:=1 to length(tmp) do
            begin
               if (tmp[i] = caracter) then
                  begin
                     ok := true;
                     delete(tmp,i,1);
                  end;
            end;
      end;
      LimpaCaracter := tmp;
end;

//------------------------------------------------------------------------------
//Verifica e faz atualização do syslog
//------------------------------------------------------------------------------
{
Function Atualiza : Boolean;
var Atual1, Atualizado1, Atual, Atualizado, Pat : String;

   arq_texto : TextFile;
begin
        Assignfile(arq_texto,'C:\NOBORULOG.txt');
        Rewrite(arq_texto);








        Pat := ExtractFilePath(ParamStr(0));

        Atualizado := verificaini(pat+ArqConfig, 'Atualiza',  'Caminho',  '',     'LER');
        Atual      := Application.ExeName;

        Atualizado1 := verificaini(pat+ArqConfig, 'Atualiza',  'Caminho',  '',     'LER');

                write(arq_texto,'Atualizado1 '); writeln(arq_texto,Atualizado1);


        Atualizado1 := copy(atualizado1,0,length(atualizado1)-10) + 'SYSLOGCFG.ini';
        Atual1      := pat + 'SYSLOGCFG.ini';


        write(arq_texto,'Pat '); writeln(arq_texto,Pat);
        write(arq_texto,'Atualizado '); writeln(arq_texto,Atualizado);
        write(arq_texto,'Atual '); writeln(arq_texto,Atual);
        write(arq_texto,'Atualizado1 '); writeln(arq_texto,Atualizado1);
        write(arq_texto,'Atual1 '); writeln(arq_texto,Atual1);



        //application.MessageBox(pchar('f-> ' + datetostr(FileDateToDateTime(FileAge(Atualizado)))), pchar('s ->'+ datetostr(FileDateToDateTime(FileAge(atual)))), 0);
        Result := true;
        if (FileAge(Atualizado) > FileAge(Atual)) or (FileAge(Atualizado1) > FileAge(Atual1))then
        begin
                //application.MessageBox(pchar('f-> ' + datetostr(FileDateToDateTime(FileAge(Atualizado)))), pchar('s ->'+ datetostr(FileDateToDateTime(FileAge(atual)))), 0);
                Executa('atualizador.exe');
                Result := false;
        end;

end;

}
Function Atualiza : Boolean;
var
   Atual1,
   Atualizado1,
   Atual,
   Atualizado,
   Pat : String;

   arq_texto : TextFile;
begin    
   StartPath := ExtractFilePath(ParamStr(0));
   if StartPath[Length(StartPath)] <> '\' then
      StartPath := StartPath + '\';

        Assignfile(arq_texto,STARTPATH+'NOBORULOG.txt');
        Rewrite(arq_texto);


        Pat := ExtractFilePath(ParamStr(0));//01
        write(arq_texto,'01 '); writeln(arq_texto,Pat);

        Atualizado := verificaini(pat+ArqConfig, 'Atualiza',  'Caminho',  '',     'LER'); //02
        write(arq_texto,'02 '); writeln(arq_texto,Atualizado);

        Atual      := Application.Name; //03
        write(arq_texto,'03 '); writeln(arq_texto,Atual);


        Atualizado1 := verificaini(pat+ArqConfig, 'Atualiza',  'Caminho',  '',     'LER'); //04
        write(arq_texto,'04 '); writeln(arq_texto,Atualizado1);

        Atualizado1 := copy(atualizado1,0,length(atualizado1)-10) + 'SYSLOGCFG.ini';//05
        write(arq_texto,'05 '); writeln(arq_texto,Atualizado1);

        Atual1      := pat + 'SYSLOGCFG.ini'; //06
        write(arq_texto,'06 '); writeln(arq_texto,Atual1);



        //application.MessageBox(pchar('f-> ' + datetostr(FileDateToDateTime(FileAge(Atualizado)))), pchar('s ->'+ datetostr(FileDateToDateTime(FileAge(atual)))), 0);
        Result := true;
        if (FileAge(Atualizado) > FileAge(Atual)) then // or (FileAge(Atualizado1) > FileAge(Atual1))then
        //if (FileAge(Atualizado) > FileAge(Atual)) then
        begin
                //application.MessageBox(pchar('f-> ' + datetostr(FileDateToDateTime(FileAge(Atualizado)))), pchar('s ->'+ datetostr(FileDateToDateTime(FileAge(atual)))), 0);
                Executa('atualizador.exe');
                Result := false;
        end;

        close(arq_texto);

end;




//------------------------------------------------------------------------------
//Compara a data de dois arquivos (Verdadeiro se A > B)
//------------------------------------------------------------------------------
Function DateFileComp(A, B : String) : Boolean ;
begin
        Result := FileAge(A) > FileAge(B);
end;


//------------------------------------------------------------------------------
//Executa um processo do windows (provavelmente não aceito em Linux)
//------------------------------------------------------------------------------
Procedure Executa(nome : String);
var
  SUInfo: TStartupInfo;
  ProcInfo: TProcessInformation;
  CmdLine: string;
begin
  FillChar(SUInfo, SizeOf(SUInfo), #0);
  with SUInfo do  begin
    cb := SizeOf(SUInfo);
    dwFlags := STARTF_USESHOWWINDOW;
    wShowWindow := 1;
  end;
  CreateProcess(nil, PChar(nome), nil, nil, false,
                NORMAL_PRIORITY_CLASS, nil,  nil, SUInfo, ProcInfo);

end;


//------------------------------------------------------------------------------
//procura um processo pelo nome de seu executável
//provavelmente não funciona em linux
//------------------------------------------------------------------------------
function BuscaProcesso(NomeExecutavel : String) : Boolean;
var
  Snapshot: THandle;
  ProcessEntry32: TProcessEntry32;
  c : integer;
begin
  result := false;
  c := 0;
// cria uma "fotografia" dos processos em execução
  Snapshot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  if (Snapshot = Cardinal(-1)) then
    exit;
  ProcessEntry32.dwSize := SizeOf(TProcessEntry32);
// pesquisa pela lista de processos
  if (Process32First(Snapshot, ProcessEntry32)) then
  repeat
// enquanto houver processos, adiciona na listview
      if (Upper(NomeExecutavel) = upper(ProcessEntry32.szExeFile)) then
      begin
        inc(c);
      end;
  until not Process32Next(Snapshot, ProcessEntry32);
// fecha "fotografia" de processos
  CloseHandle(Snapshot);
  if c > 1 then result := true;
end;
//*****************************************************************************

//------------------------------------------------------------------------------
function Is4DigitYear: Boolean; // BY NOBOW BOY
begin
  //result:=(Pos('yyyy',ShortDateFormat)>0);
end;
//------------------------------------------------------------------------------
function criaLote : String; // BY NOBOW BOY
var
   lote,
   tmp : String;

   dia,
   ano : integer;
begin

  dia := DayOfTheYear(date);

  tmp := inttostr(yearof(date));
  if Is4DigitYear then
     tmp := copy(tmp,3,2);

  lote := tmp + LimpaCodigo(IntToStr(dia),3);

  Result := lote;


end;

//******************************************************************************
function formaNumeroOF(nof : String) : String;
var
   posicao : integer;
begin

    posicao := pos('/', nof);
    if posicao > 0 then
            NOF := LimpaCodigo(copy(nof, 1, posicao - 1), 6) + copy(nof, posicao, length(nof) - (posicao - 1))
    else
       begin
          nof := LimpaCodigo(nof, 6);
          nof := nof + '/' + Copy(datetostr(Date),9,2);
       end;


    Result := nof;
end;
//--------------------------------------------------------------------------------





function PadZero(DADO: string; COMPR: byte): string;
var
  TEMP: string;
begin
  TEMP := AllTrim(DADO);
  while Length(TEMP) < COMPR do
    TEMP := TEMP + '0';
  Result := Copy(TEMP, 1, COMPR);
end;

function ultimodiadomes(mes: integer;ano: integer) : integer;
begin
   Case mes of
      1,3,5,7,8,10,12: ultimodiadomes := 31;
      4,6,9,11: ultimodiadomes := 30;
      2: begin
            if (ano mod 100) > 0 then // não termina em "00"
               if (Ano mod 4) = 0 then
                  ultimodiadomes := 29 // é bissexto
               else
                  ultimodiadomes := 28
            else // termina em "00"
               if (Ano mod 400) = 0 then
                  ultimodiadomes := 29 // é bissexto
               else
                  ultimodiadomes := 28;
         end;
   end;
end;

function PegaMesAtual:string;
begin
  PegaMesAtual := Copy ( DateToStr(date), 4, 7);
end;

function MoedatoFloat(valor: string; moeda: char) : real;
begin
   // Samuca - Para não dar erro quando o campo vier em branco
   if valor = '' then
     if (moeda = 'R') or (moeda = 'E') then
       valor := '0,00'
     else
       valor := '0.00';

   if moeda = 'R' then // real
      begin
         valor := LimpaCaracter(valor,'.');
//         if decimalseparator = ',' then
//            MoedatoFloat := strtofloat(valor)
//         else
            MoedatoFloat := strtofloat(TrocaCaracter(valor,',','.'));
      end
   else
     if moeda = 'E' then // euro
        begin
           valor := LimpaCaracter(valor,'.');
//           if decimalseparator = ',' then
//              MoedatoFloat := strtofloat(valor)
//           else
              MoedatoFloat := strtofloat(TrocaCaracter(valor,',','.'));
        end
     else // dólar
        begin
           valor := LimpaCaracter(valor,',');
//           if decimalseparator = '.' then
//              MoedatoFloat := strtofloat(valor)
//           else
              MoedatoFloat := strtofloat(TrocaCaracter(valor,'.',','));
        end;
end;

function FloattoMoeda(valor: real; moeda: char) : string;
var convertido: string;
    decsepaux, thousepaux: char;
begin
//   decsepaux := decimalseparator;
//   thousepaux := thousandseparator;
//   if (moeda = 'R') or (moeda = 'E') then // real ou euro
//      begin
//         decimalseparator := ',';
//         thousandseparator := '.';
//      end
//   else // dólar
//      begin
//         decimalseparator := '.';
//         thousandseparator := ',';
//      end;

   // Samuca - 13/12/2011 - Tratamento para a string NAN que é utlizada na variável real pelo Firebird   
   try
     FloattoMoeda := FormatFloat('###,###,###,##0.00',valor)
   except
     FloattoMoeda := FormatFloat('###,###,###,##0.00', 0.00)
   end;
//   decimalseparator := decsepaux;
//   thousandseparator := thousepaux;
end;

function LimpaUnder(DADO: string): string;
var
  TEMP: string;
begin
  TEMP := DADO;
  while (Length(TEMP) > 0) and (TEMP[1] = '_') do
    Delete(TEMP, 1, 1);
  while (Length(TEMP) > 0) and (TEMP[Length(TEMP)] = '_') do
    Delete(TEMP, Length(TEMP), 1);

  LimpaUnder := TEMP;
end; { LimpaUnder }


function ExtraiChaveNFE(arquivo :string):string;
var NomeArquivo : string;
begin
  NomeArquivo := ExtractFileName(arquivo);

  ExtraiChaveNFE := Copy (NomeArquivo, 1, 44);
end; {ExtraiChaveNFE}


function MudaDataSefaz(DADO: string):string;
var AuxData, AuxHora : string;

begin
  //<dhRecbto>2012-04-13T10:44:55</dhRecbto>
  AuxData := Copy (DADO, 9, 2) + '/' +
             Copy (DADO, 6, 2) + '/' +
             Copy (DADO, 1, 4);

  AuxHora := Copy (DADO, 12, 8);

  MudaDataSefaz := AuxData + ' ' + AuxHora;
end; {MudaDataSefaz}



function RemoveQuebraLinha(sString: string): string;
var i: Integer;
    s: String;
begin
  //  #13#10
  for i:=1 to Length(sString) do
    begin
    if (Copy(sString, i, 1) = chr(13)) or (Copy(sString, i, 1) = chr(10)) then
      s:=s + ' '
    else
      s:=s + Copy(sString, i, 1);
    end;
  Result:=s;
end;

function GetPIDExecutavel( const ANome: String ): Cardinal;
  var
    MContinueLoop: BOOL;
    MHandle: THandle;
    MProcList: TProcessEntry32;
    MLocated: Boolean;
  begin

    result := 0;

    MHandle := CreateToolhelp32Snapshot( TH32CS_SNAPPROCESS, 0 );
    MProcList.dwSize := SizeOf( MProcList );
    MContinueLoop := Process32First( MHandle, MProcList );

    while Integer( MContinueLoop ) <> 0 do
      begin

        MLocated := ( ( UpperCase( ExtractFileName( MProcList.szExeFile ) ) = UpperCase( ANome ) ) or ( UpperCase( MProcList.szExeFile ) = UpperCase( ANome ) ) );

        if MLocated then
          begin

            result := MProcList.th32ProcessID;
            Break;

          end;

        MContinueLoop := Process32Next( MHandle, MProcList );

      end;

    CloseHandle( MHandle );

  end;

function GetHWNDFromPID( const pid: Cardinal ): HWND;
  var
    MHandle: HWND;
    MProcPID: Cardinal;
  begin

    result := 0;
    MHandle := GetTopWindow( 0 );

    while Boolean( MHandle ) do
      begin

        { ** O retorno do método não é necessário. Apenas o seu Handle ** }
        GetWindowThreadProcessId( MHandle, MProcPid );

        if MProcPid = pid then
          begin

            result := MHandle;
            Break;

          end;

        { ** Recuperando a próxima janela ** }
        MHandle := GetNextWindow( MHandle, GW_HWNDNEXT );

      end;
end;

function ObtemIBPT(NCM, mercado: string): real;
var qry: TIBQuery;
begin
   qry := TIBQuery.Create(nil);
   qry.database:=DM_Config.IBDB;
   qry.Close;
   qry.Active := False;
   qry.SQL.Text := 'Select first 1 IBPT_CODIGO, IBPT_VERSAO, IBPT_ALIQNAC, IBPT_ALIQIMP FROM T_IBPT where IBPT_CODIGO = '+#39+NCM+#39;
   qry.Active := true;
   if qry.IsEmpty then
      begin
         //Application.ProcessMessages(PChar('IBPT: NCM '+NCM+' não encontrada. Avise o departamento de sistemas!'),  PChar(SystemName), [smbok] , smsCritical);
         ObtemIBPT := 0;
      end
   else
      begin
         if mercado = 'I' then // mercado interno
            ObtemIBPT := qry.fieldbyname('IBPT_ALIQNAC').AsFloat
         else
            ObtemIBPT := qry.fieldbyname('IBPT_ALIQIMP').AsFloat;
      end;
end;

function FormatReal6(valor: string): boolean;
var x: integer;
  y: string;
  Resultado: boolean;
  posaux: integer;
begin
  Resultado := False;
  x := length(Alltrim(valor));
  // formata com 6 casas decimais
//  if (x < 8) then
//     begin
        posaux := pos(',',valor);
        if posaux > 0 then
           valor := copy(valor,1,posaux) + PadRlimpacodigo(copy(valor,posaux+1,length(valor)-posaux),6)
        else
           valor := valor + ',000000';
//     end;
  ///////////////////////////////
  if (valor = '0,000000') or (x=11) or (valor = '0.000,000000') then
    Resultado := False
  else
    if x <= 10 then
    begin
      y := limpacodigomoeda(valor, 10);
      x := length(y);
      if (y[x] in ['0'..'9']) then
        if (y[x - 1] in ['0'..'9']) then
           if (y[x - 2] in ['0'..'9']) then
              if (y[x - 3] in ['0'..'9']) then
                 if (y[x - 4] in ['0'..'9']) then
                   if (y[x - 5] in ['0'..'9']) then
                     if (y[x - 6] in [',']) then
                       if (y[x - 7] in ['0'..'9']) or (y[3] = '') then
                          if (y[x - 8] in ['0'..'9']) or (y[2] = '') then
                             if (y[x - 9] in ['0'..'9']) or (y[1] = '') then
                                Resultado := True;
    end
    else
      if x > 10 then
      begin
        y := limpacodigomoeda(valor, 17);
        x := length(y);
        if (y[x] in ['0'..'9']) then
          if (y[x - 1] in ['0'..'9']) then
             if (y[x - 2] in ['0'..'9']) then
                if (y[x - 3] in ['0'..'9']) then
                   if (y[x - 4] in ['0'..'9']) then
                      if (y[x - 5] in ['0'..'9']) then
                        if (y[x - 6] in [',']) then
                          if (y[x - 7] in ['0'..'9']) then
                            if (y[x - 8] in  ['0'..'9']) or (y[x - 8] = '') then
                              if (y[x - 9] in ['0'..'9'])  or (y[x - 9] = '') then
                                if (y[x - 10] in  ['.']) or (y[x - 10] = '') then
                                  if (y[x - 11] in ['0'..'9']) or (y[x - 11] = '') then
                                     if (y[x - 12] in ['0'..'9']) or (y[x - 12] = '') then
                                        if (y[x - 13] in ['0'..'9']) or (y[x - 13] = '') then
                                           if (y[x - 14] in  ['.']) or (y[x - 14] = '') then
                                              if (y[x - 15] in ['0'..'9']) or (y[x - 15] = '') then
                                                 if (y[x - 16] in ['0'..'9']) or (y[x - 16] = '') then
                                                    if (y[x - 17] in ['0'..'9']) or (y[x - 17] = '') then
                                                       Resultado := True;
      end;
  FormatReal6 := Resultado;
end;

function FormatDolar6(valor: string): boolean;
var x: integer;
  y: string;
  Resultado: boolean;
  posaux: integer;
begin
  Resultado := False;
  x := length(alltrim(valor));
  // formata com 6 casas decimais
//  if (x < 8) then
//     begin
        posaux := pos('.',valor);
        if posaux > 0 then
           valor := copy(valor,1,posaux) + PadRlimpacodigo(copy(valor,posaux+1,length(valor)-posaux),6)
        else
           valor := valor + '.000000';
//     end;
  ///////////////////////////////
  if (valor = '0.000000') or (x = 11) or (valor = '0,000.000000') then
    Resultado := False
  else
    if x <= 10 then
    begin
      y := limpacodigomoeda(valor, 10);
      x := length(y);
      if (y[x] in ['0'..'9']) then
        if (y[x - 1] in ['0'..'9']) then
           if (y[x - 2] in ['0'..'9']) then
              if (y[x - 3] in ['0'..'9']) then
                 if (y[x - 4] in ['0'..'9']) then
                    if (y[x - 5] in ['0'..'9']) then
                       if (y[x - 6] in ['.']) then
                          if (y[x - 7] in ['0'..'9']) then
                             if (y[x - 8] in ['0'..'9']) or (y[2] = '') then
                                if (y[x - 9] in ['0'..'9']) or (y[1] = '') then
                  Resultado := True;
    end
    else
      if x > 10 then
      begin
        y := limpacodigomoeda(valor, 17);
        x := length(y);
        if (y[x] in ['0'..'9']) then
          if (y[x - 1] in ['0'..'9']) then
             if (y[x - 2] in ['0'..'9']) then
                if (y[x - 3] in ['0'..'9']) then
                   if (y[x - 4] in ['0'..'9']) then
                      if (y[x - 5] in ['0'..'9']) then
                        if (y[x - 6] in ['.']) then
                          if (y[x - 7] in ['0'..'9']) then
                            if (y[x - 8] in  ['0'..'9']) or (y[x - 8] = '') then
                              if (y[x - 9] in ['0'..'9'])  or (y[x - 9] = '') then
                                if (y[x - 10] in  [',']) or (y[x - 10] = '') then
                                  if (y[x - 11] in ['0'..'9']) or (y[x - 11] = '') then
                                     if (y[x - 12] in ['0'..'9']) or (y[x - 12] = '') then
                                        if (y[x - 13] in ['0'..'9']) or (y[x - 13] = '') then
                                           if (y[x - 14] in  [',']) or (y[x - 14] = '') then
                                              if (y[x - 15] in ['0'..'9']) or (y[x - 15] = '') then
                                                 if (y[x - 16] in ['0'..'9']) or (y[x - 16] = '') then
                                                    if (y[x - 17] in ['0'..'9']) or (y[x - 17] = '') then
                                                       Resultado := True;
      end;
  FormatDolar6 := Resultado;
end;

function FormatEuro6(valor: string): boolean;
var x: integer;
  y: string;
  Resultado: boolean;
  posaux: integer;
begin
  Resultado := False;
  x := length(Alltrim(valor));
  // formata com 6 casas decimais
  if (x < 8) then
     begin
        posaux := pos(',',valor);
        if posaux > 0 then
           valor := copy(valor,1,posaux) + PadRlimpacodigo(copy(valor,posaux+1,length(valor)-posaux),6)
        else
           valor := valor + ',000000';
     end;
  ///////////////////////////////
  if (valor = '0,000000') or (x=11) or (valor = '0.000,000000') then
    Resultado := False
  else
    if x <= 10 then
    begin
      y := limpacodigomoeda(valor, 10);
      x := length(y);
      if (y[x] in ['0'..'9']) then
        if (y[x - 1] in ['0'..'9']) then
           if (y[x - 2] in ['0'..'9']) then
              if (y[x - 3] in ['0'..'9']) then
                 if (y[x - 4] in ['0'..'9']) then
                   if (y[x - 5] in ['0'..'9']) then
                     if (y[x - 6] in [',']) then
                       if (y[x - 7] in ['0'..'9']) or (y[3] = '') then
                          if (y[x - 8] in ['0'..'9']) or (y[2] = '') then
                             if (y[x - 9] in ['0'..'9']) or (y[1] = '') then
                                Resultado := True;
    end
    else
      if x > 10 then
      begin
        y := limpacodigomoeda(valor, 17);
        x := length(y);
        if (y[x] in ['0'..'9']) then
          if (y[x - 1] in ['0'..'9']) then
             if (y[x - 2] in ['0'..'9']) then
                if (y[x - 3] in ['0'..'9']) then
                   if (y[x - 4] in ['0'..'9']) then
                      if (y[x - 5] in ['0'..'9']) then
                        if (y[x - 6] in [',']) then
                          if (y[x - 7] in ['0'..'9']) then
                            if (y[x - 8] in  ['0'..'9']) or (y[x - 8] = '') then
                              if (y[x - 9] in ['0'..'9'])  or (y[x - 9] = '') then
                                if (y[x - 10] in  ['.']) or (y[x - 10] = '') then
                                  if (y[x - 11] in ['0'..'9']) or (y[x - 11] = '') then
                                     if (y[x - 12] in ['0'..'9']) or (y[x - 12] = '') then
                                        if (y[x - 13] in ['0'..'9']) or (y[x - 13] = '') then
                                           if (y[x - 14] in  ['.']) or (y[x - 14] = '') then
                                              if (y[x - 15] in ['0'..'9']) or (y[x - 15] = '') then
                                                 if (y[x - 16] in ['0'..'9']) or (y[x - 16] = '') then
                                                    if (y[x - 17] in ['0'..'9']) or (y[x - 17] = '') then
                                                       Resultado := True;
      end;
  FormatEuro6 := Resultado;
end;

function PadRLimpaCodigo(DADO: string; COMPR: byte): string;
var
  TEMP: string;
  i: byte;
begin
  TEMP := DADO;
  for i := Length(TEMP) downto 1 do
    if Pos(TEMP[i], NUMEROS) <= 0 then
      Delete(TEMP, i, 1);
  while Length(TEMP) < COMPR do
    TEMP := TEMP + '0';
  PadRLimpaCodigo := TEMP;
end; { LimpaCodigo }

function StringtoFloat(valor: string) : real;
var caracterdecimalvalor: char;
    caracterdecimalsistema: char;
    x: integer;
begin
   //caracterdecimalsistema := decimalseparator;
   valor := alltrim(valor);
   if valor = '' then
      //valor := '0'+decimalseparator+'00';
   caracterdecimalvalor := #0;
   For x := length(valor) downto 1 do // verifica o primeiro caracter não numérico, este será o caracter decimal
      begin
         if caracterdecimalvalor = '' then // se for vazio ainda não achou casa decimal
            begin
               if not(valor[x] in ['0'..'9']) then // verifica se é número ou caracter, se for caracter este será a casa decimal
                  caracterdecimalvalor := valor[x];
            end
         else // já tem casa decimal definida
            if not(valor[x] in ['0'..'9']) then // verifica se é número, se não for, exclui caracter
               delete(valor,x,1);
      end;
   if caracterdecimalvalor = '' then
      caracterdecimalvalor := caracterdecimalsistema;
   if caracterdecimalvalor <> caracterdecimalsistema then
      valor := trocacaracter(valor,caracterdecimalvalor,caracterdecimalsistema); // se caracter decimal do valor não for igual ao do sistema, então troca um pelo outro
   stringtofloat := strtofloat(valor);
end;

function arredonda6(Valor : Real):Real;
var Teste_FloatToStr : string;
    Teste_ContaDecimal6 : string;
    Teste_ConfiguraMoeda6 : string;
    Teste_StringToFloat : real;

begin
  Teste_FloatToStr      := FloattoStr(valor);
  Teste_ContaDecimal6   := contadecimal6(Teste_FloatToStr);
  Teste_ConfiguraMoeda6 := configuramoeda6(Teste_ContaDecimal6,true,false);
  Teste_StringToFloat   := stringtofloat(Teste_ConfiguraMoeda6);
  arredonda6 := Teste_StringToFloat;
end;

function IniciaImpressao(NomeArquivo: string): boolean; // esta função abre o arquivo máscara e abre o arquivo destino para geração de várias etiquetas em um único arquivo
begin
  MSaidaImpressao := Copy(NomeArquivo, 1, Length(NomeArquivo) - 3) + 'PRN';
  if FileExists(NomeArquivo) then
     begin
        // Atribui valores para variaveis de merge
        AssignFile(MArqZplImpressao, NomeArquivo);
        {I$} Reset(MArqZplImpressao); {+I$}
        if IOResult = 0 then
           begin
              // Verifica se o arquivo será aberto para tratamento do Merge
              AssignFile(MArqSaidaImpressao, MSaidaImpressao);
              {I$} Rewrite(MArqSaidaImpressao); {+I$}
              IniciaImpressao := true;
           end
        else
           begin
              IniciaImpressao := false;
           end;
     end
  else
     IniciaImpressao := false;
end;

procedure GeraArquivoImpressao(NomeArquivo: string);
var
  MLinha: string;
begin
   if FileExists(NomeArquivo) then
      begin
         // Atribui valores para variaveis de merge
         {I$} Reset(MArqZplImpressao); {+I$}
         if IOResult = 0 then
            begin
               while not eof(MArqZplImpressao) do
                  begin
                     ReadLn(MArqZPLImpressao, MLinha);
                     MLinha := MergeDados(MLinha, 1);
                     //MLinha := Filtra(MLinha);
                     WriteLn(MArqSaidaImpressao, MLinha);
                  end;
            end;
      end;
end;

function FinalizaImpressao(NomeArquivo: string): boolean;
begin
   if FileExists(NomeArquivo) then
      begin
         CloseFile(MArqSaidaImpressao);
         CloseFile(MArqZplImpressao);
         CopyFile( pchar(MSaidaImpressao), pchar(PRINTSaida), oksend );
         delay(1000); // LM - 14/10/2010 dá uma pausa para resolver problema de impressão USB
//         CopyFile(pchar(NomeArquivo), pchar(MSaidaImpressao), oksend);
//         if not oksend then
//            begin
//               delay(1000); // LM - 14/10/2010 dá uma pausa para resolver problema de impressão USB
//               CopyFile(pchar(NomeArquivo), pchar(MSaidaImpressao), oksend);
//               CopyFile( pchar(MSaidaImpressao), pchar(PRINTSaida), oksend );
//           end;
         FinalizaImpressao := true;
      end
   else
      FinalizaImpressao := false;
end;

function ObtemPartilha:boolean;
var Aux_Data : string;
    Aux_Ano  : integer;
begin
   Aux_Data := DateToStr(Date);
   Aux_Ano  := StrToInt(Copy(Aux_Data, 7, 4));

   // Samuca - 23/03/2016 - Obtem os percentuais de partilha
//   DM_Cadastro.IB_Pesquisa.Active := false;
//   DM_Cadastro.IB_Pesquisa.SQL.Clear;
//   DM_Cadastro.IB_Pesquisa.SQL.Add('SELECT * ');
//   DM_Cadastro.IB_Pesquisa.SQL.Add('FROM T_DIFAL ');
//   DM_Cadastro.IB_Pesquisa.SQL.Add('WHERE DIF_ANO = '+IntToStr(Aux_Ano)+' ');
//   DM_Cadastro.IB_Pesquisa.Active := true;
//
//   if (DM_Cadastro.IB_Pesquisa.IsEmpty) then
//     begin
//       PartilhaOrigem  := 0;
//       PartilhaDestino := 100;
//       ObtemPartilha := False
//     end
//   else
//     if TemDifalPartilha then
//       begin
//         // Quando a CFOP deve fazer a partilha entre a origem e destino
//         PartilhaOrigem  := DM_Cadastro.IB_Pesquisa.FieldByName('DIF_ORIGEM').AsFloat;
//         PartilhaDestino := DM_Cadastro.IB_Pesquisa.FieldByName('DIF_DESTINO').AsFloat;
//         ObtemPartilha := True;
//       end
//     else
//       begin
//         // Quando a CFOP não deve fazer a partilha entre a origem e destino
//         PartilhaOrigem  := 0;
//         PartilhaDestino := 100;
//         ObtemPartilha := True;
//       end;
end;

function FormataNumeroOF(NumOF:string): string;
var nof: string;
    posicao: integer;
begin
  nof := NumOF;
  posicao := pos('/', nof);
  if posicao > 0 then
     NOF := LimpaCodigo(copy(nof, 1, posicao - 1), 6) + copy(nof, posicao, length(nof) - (posicao - 1))
  else
     begin
        NOF := LimpaCodigo(NOF, 6);
        Nof := Nof + '/' + Copy(datetostr(Date),9,2);
     end;
  FormataNumeroOF := Nof;
end;

function FormataNumeroOS(NumOS:string):string;
var osformatada: string;
    Year, Month, Day : Word;
begin
  NumOS := alltrim(NumOS);
  // formata número de OS
  if length(NumOS) < 9 then
     begin
        DecodeDate(date,Year, Month, Day);
        if pos('/',NumOS) > 0 then
           begin
              osformatada := 'OS'+LimpaCodigo(copy(NumOS,1,pos('/',NumOS)-1),4)+'/'+ LimpaCodigo(copy(NumOS,pos('/',NumOS)+1,2),2);
              FormataNumeroOS := osformatada;
           end
        else
           begin
              osformatada := 'OS'+LimpaCodigo(NumOS,4) + '/'+ LimpaCodigo(copy(inttostr(year),3,2),2);
              FormataNumeroOS := osformatada;
           end;
     end
  else
     FormataNumeroOS := NumOS;
end;

function AchaChaveNFE(nf: string; serienf: string):string;
var retorno: string;
    qry: TIBQuery;
begin
   retorno := '';
   qry := TIBQuery.Create(nil);
   qry.Database := DM_Config.IBDB;
   qry.Close;
   qry.SQL.Clear;
   qry.SQL.Add('select NF_CHAVENFE from T_NOTA_FISCAL_COMERCIAL ');
   qry.SQL.Add('where NF_NUMERO =:vNF ');
   qry.SQL.Add(' and ');
   qry.SQL.Add('NF_SERIE = :vSERIENF ');
   qry.ParamByName('vNF').AsString := nf;
   qry.ParamByName('vSERIENF').AsString := serienf;
   qry.Open;
   if not qry.isempty then
      retorno := qry.fieldbyname('NF_CHAVENFE').Asstring;
   AchaChaveNFE := retorno;
end;

function dgCreateProcess(const FileName: string): boolean;
var ProcInfo: TProcessInformation;
    StartInfo: TStartupInfo;
begin
     FillMemory(@StartInfo, sizeof(StartInfo), 0);
     StartInfo.cb := sizeof(StartInfo);
     result := CreateProcess(
                   nil,
                   PChar(FileName),
                   nil, Nil, False,
                   NORMAL_PRIORITY_CLASS,
                   nil, nil,
                   StartInfo,
                   ProcInfo);
     CloseHandle(ProcInfo.hProcess);
     CloseHandle(ProcInfo.hThread);
{var ProcInfo: TProcessInformation;
    StartInfo: TStartupInfo;
begin
     FillMemory(@StartInfo, sizeof(StartInfo), 0);
     StartInfo.cb := sizeof(StartInfo);
//     result :=
     Win32Check(CreateProcess(
                   nil,
                   PChar(FileName),
                   nil, Nil, False,
                   NORMAL_PRIORITY_CLASS,
                   nil, nil,
                   StartInfo,
                   ProcInfo));;
  //Colocado verificação processo para voltar cursor ao normal
  try
    Win32Check(WaitForSingleObject(ProcInfo.hProcess, INFINITE)=WAIT_OBJECT_0);
  finally
    CloseHandle(ProcInfo.hProcess);
    CloseHandle(ProcInfo.hThread);
    Screen.Cursor := 0;
  end;  }
end;

function AtualizaHistoricoProduto(produto,campo,valorantigo,valornovo,nform:string):boolean;
var qry: TIBQuery;
    vID: string;
begin
   qry := TIBQuery.Create(nil);
   qry.Database := DM_Config.IBDB;
   qry.Close;
   qry.SQL.Clear;
   // Obtem último registro de histórico
   qry.SQL.Text := 'select cast(max(thn_id) as bigint) from t_historico_nserie';
   qry.Open;
   vID := LimpaCodigo(inttostr(qry.Fields[0].Value + 1),16);
   qry.Close;
   // Cria o registro mestre na tabela de historico //
   qry.SQL.Clear;
   qry.SQL.text := 'insert into t_historico_nserie (THN_ID, THN_PRODUTO, THN_NSERIE, THN_DATA, THN_OPERADOR, THN_FORM, '+
                   'THN_OF, THN_NOTA, THN_DESCRICAO, THN_STATUS, THN_OS) values '+
                   '('+#39+vID+#39+', '+#39+produto+#39+', '', :datahora, '+#39+NomeUsuario+#39+','+#39+nform+#39+', '+
                   ''+#39+#39+','+#39+#39+', '+#39+'Alteração de dado(s) do produto'+#39+', 0,'+#39+#39+')';
   qry.ParamByName('datahora').AsDateTime := now;
   qry.ExecSQL;
   qry.SQL.Clear;
   qry.SQL.Text := 'insert into t_historico_upd (HUT_ID, HUT_NOMECAMPO, HUT_TABELA, '+
                   'HUT_VALORORIGINAL, HUT_VALORFINAL, '+
                   'HUT_OPERADOR, HUT_DATAHORA) VALUES '+
                   '('+#39+vID+#39+', '+#39+campo+#39+', '+#39+'PRODUTO'+#39+', '+
                   ':valorantigo,:valornovo, '+
                   ''+#39+NomeUsuario+#39+', :datahora)';
   //qry.ParamByName('valorantigo').AsBlob := valorantigo;
   //qry.ParamByName('valornovo').AsBlob := valornovo;
   qry.ParamByName('datahora').AsDateTime := now;
   qry.ExecSQL;
   Freeandnil(qry);
end;

function BuscaProduto(Produto : string): string;
var Qry: TIBQuery;
    Descricao : string;
begin
   Qry := TIBQuery.Create(nil);
   Qry.Database := DM_Config.IBDB;
   Qry.Close;
   Qry.SQL.Clear;
   // Obtem último registro de histórico
   Qry.SQL.Text := 'SELECT tprcodprodsys, tprdescfatura ' +
                   '  FROM t_produto ' +
                   ' WHERE tprcodprodsys = :tprcodprodsys';
   Qry.ParamByName('tprcodprodsys').AsString := Produto;
   Qry.Open;

   if Qry.IsEmpty then
     Descricao := '<SEM CADASTRO>'
   else
     Descricao := Qry.FieldByName('TPRDESCFATURA').AsString;

   Qry.Close;
   Freeandnil(Qry);
   BuscaProduto := Descricao;
end;


function BuscaEmailContato(Cliente: string; Planta:Integer; Contato:string):string;
var Qry: TIBQuery;
    Descricao : string;
begin
   Qry := TIBQuery.Create(nil);
   Qry.Database := DM_Config.IBDB;
   Qry.Close;
   Qry.SQL.Clear;
   // Obtem último registro de histórico
   Qry.SQL.Text := 'SELECT tcemail ' +
                   '  FROM t_contato ' +
                   ' WHERE tccodentidade = :entidade ' +
                   '   AND tcplanta = :planta ' +
                   '   AND tccodcontato = :codigo';
   Qry.ParamByName('entidade').AsString := Cliente;
   Qry.ParamByName('planta').AsInteger  := Planta;
   Qry.ParamByName('codigo').AsString   := Contato;
   Qry.Open;

   if Qry.IsEmpty then
     Descricao := '- - -'
   else
     Descricao := Qry.FieldByName('tcemail').AsString;

   Qry.Close;
   Freeandnil(Qry);
   BuscaEmailContato := Descricao;
end;




function BuscaFornecedor(Codigo : string; Planta : integer): string;
var Qry: TIBQuery;
    Descricao : string;
begin
   Qry := TIBQuery.Create(nil);
   Qry.Database := DM_Config.IBDB;
   Qry.Close;
   Qry.SQL.Clear;
   // Obtem último registro de histórico
   Qry.SQL.Text := 'SELECT razaofor ' +
                   '  FROM t_fornecedores ' +
                   ' WHERE codfor =  :vcodfor' +
                   '   AND plantafor = :vplantafor' ;
   Qry.ParamByName('vcodfor').AsString     := Codigo;
   Qry.ParamByName('vplantafor').AsInteger := Planta;
   Qry.Open;

   if Qry.IsEmpty then
     Descricao := '<SEM CADASTRO>'
   else
     Descricao := Qry.FieldByName('RAZAOFOR').AsString;

   Qry.Close;
   Freeandnil(Qry);
   BuscaFornecedor := Descricao;
end;



procedure ExecutaCreditoAutomatico(CodOF: string);
var Qry: TIBQuery;
    parecer: string;
    Aux: real;
begin
   Qry := TIBQuery.Create(nil);
   Qry.Database := DM_Config.IBDB;
   // Obtem porcentagem da comissão
   Qry.Active := false;
   Qry.SQL.Clear;
   Qry.SQL.Text := 'select EVCODIGO, EVPORCCOMISSAO from T_EVENTOS where EVTIPO = 1 and EVDATAINICIO < :data and EVSTATUS = '+#39+'1'+#39+' and ((EVDATATERMINO is null) or ((EVDATATERMINO > :data) and (EVDATATERMINO is not null)))';
   Qry.ParamByName('data').AsDatetime := now;
   Qry.Open;
   Aux := stringtofloat(qry.fieldbyname('EVPORCCOMISSAO').Asstring);

   /// Faz o lançamento automático da análise de crédito
   Qry.Close;
   Qry.SQL.Clear;
   qry.SQL.Add('update t_ordem_fatura_comercial set');
   qry.SQL.Add('OF_LIBCREDITO   = 1,');
   qry.SQL.Add('OF_USUARIOCREDITO = '+#39+NomeUsuario+#39+', ');
   qry.SQL.Add('OF_DATACREDITO = :datacredito, ');
   qry.SQL.Add('OF_PARECERCREDITO = OF_PARECERCREDITO || :parecercredito, ');
   qry.SQL.Add('OF_FATURAMENTO = ' + #39 +  '' + #39 );
   qry.SQL.Add('where of_cod = '+#39+CodOF+#39);
   qry.ParamByName('datacredito').AsDatetime := now;
   Parecer := #13+'Aprovado por : ' + NomeUsuario + ' em ' + DateTimeToStr(now)+#13+'============================================================';
   qry.ParamByName('parecercredito').AsMemo  := Parecer;
   qry.ExecSQL;
   //DM_DI.GravaHistorico(NomeUsuario,'16', 'Aprov. Aut. Cred.', CodOF);
   Qry.Close;


   // Faz o lançamento automático da comissão
   //DM_Comissao.LancamentoComissao(Codof,date,aux);
  // DM_DI.GravaHistorico(NomeUsuario,'016', 'Lanc.Aut.Comiss.', CodOF + ' - ' + '4' + '%' );
   Qry := TIBQuery.Create(nil);
   Qry.Database := DM_Config.IBDB;
   Qry.Active := False;
   Qry.SQL.Clear;
   Qry.SQL.Text := 'UPDATE T_ORDEM_FATURA_COMERCIAL SET ' +
                   '  OF_PORC_LIB_COMISSAO = :porclibcomissao, '+
                   '  OF_VALOR_LIB_COMISSAO = of_comissaoof, '+ // calculado em "DM_Comissao.LancamentoComissao"
                   '  OF_USUARIOLIBCOMISSAO = '+#39+NomeUsuario+#39+', '+
                   '  OF_DATALIBCOMISSAO = :datacredito, '+
                   '  OF_FATURAMENTO = ' + #39 +  '' + #39 + ', '+
                   '  OF_LIBCOMISSAO = 1 ' +
                   'WHERE OF_COD = ' + #39 + CodOF + #39;
   Qry.ParamByName('porclibcomissao').AsFloat := aux;
   qry.ParamByName('datacredito').AsDatetime := now;
   Qry.ExecSQL;
   DM_Config.IBTransaction.CommitRetaining;
   //Application.MessageBox('Crédito Aprovado com sucesso! A O.F. agora está disponível para liberação.', 'Análise de Crédito', [smbOK], smsWarning);
   Freeandnil(Qry);
end;

procedure ExecutaCreditoAutomaticoContrato(Lancamento: string);
var Qry, Q_LCRComissao: TIBQuery;
    parecer: string;
    Aux: real;
    aliqpis, aliqcofins, valorfatura, valorpis, valorcofins, basecomissao, vltotalcomissao: real;
begin
   Qry := TIBQuery.Create(nil);
   Qry.Database := DM_Config.IBDB;
   Q_LCRComissao := TIBQuery.Create(nil);
   Q_LCRComissao.Database := DM_Config.IBDB;

   // Obtem porcentagem da comissão
   Qry.Active := false;
   Qry.SQL.Clear;
   Qry.SQL.Text := 'select EVCODIGO, EVPORCCOMISSAO from T_EVENTOS where EVTIPO = 1 and EVDATAINICIO < :data and EVSTATUS = '+#39+'1'+#39+' and ((EVDATATERMINO is null) or ((EVDATATERMINO > :data) and (EVDATATERMINO is not null)))';
   Qry.ParamByName('data').AsDatetime := now;
   Qry.Open;
   Aux := stringtofloat(qry.fieldbyname('EVPORCCOMISSAO').Asstring);
   qry.Close;
   qry.SQL.Clear;
   qry.SQL.Add('update t_lancamentos_cr set');
   qry.SQL.Add('LCR_LIBCREDITO   = 1,');
   qry.SQL.Add('LCR_USUARIOCREDITO = '+#39+NomeUsuario+#39+', ');
   qry.SQL.Add('LCR_DATACREDITO = :datacredito, ');
   qry.SQL.Add('LCR_PARECERCREDITO = :parecercredito ');
   qry.SQL.Add('where LCR_LANCAMENTO = '+#39+Lancamento+#39);
   qry.ParamByName('datacredito').AsDatetime := now;
   Parecer := #13+'Aprovado por : ' + NomeUsuario + ' em ' + DateTimeToStr(now)+#13+'============================================================';
   qry.ParamByName('parecercredito').AsMemo  := Parecer;
   qry.ExecSQL;
   //DM_DI.GravaHistorico(NomeUsuario,'199', 'Aprov.Aut.Créd.LCR', Lancamento);

   // Lançamento automático da comissao
   Q_LCRComissao.Active := false;
   Q_LCRComissao.SQL.Text := 'select * from T_LANCAMENTOS_CR where LCR_LANCAMENTO = '+#39+Lancamento+#39;
   Q_LCRComissao.Active := true;
   qry.Close;
   qry.SQL.text := 'select * from T_PIS_COFINS';
   qry.Open;
   if ( qry.FieldByName( 'PIS' ).AsString <> '' ) and ( qry.FieldByName( 'PIS' ).AsString <> '0' ) then
     aliqpis := stringtofloat(qry.FieldByName( 'PIS' ).AsString)
   else
     aliqpis := 0;
   if ( alltrim(qry.FieldByName( 'COFINSINTERNO' ).AsString) <> '' ) and ( alltrim(qry.FieldByName( 'COFINSINTERNO' ).AsString) <> '0' ) then
     aliqcofins := Stringtofloat(alltrim(qry.FieldByName( 'COFINSINTERNO' ).AsString))
   else
     aliqcofins := 0;
   qry.Close;
   valorfatura := MoedaToFloat(Q_LCRComissao.FieldByName('LCR_VALORCONTRATO').AsString, 'R') * Q_LCRComissao.FieldByName('LCR_NPERIODOS').AsInteger;
   // Calcula Valor Pis
   valorpis    := (valorfatura) * (aliqpis / 100);
   // Calcula Valor Cofins
   valorcofins := (valorfatura) * (aliqcofins / 100);
   // Calcula a base da comissão
   BaseComissao := ValorFatura - ValorPis - ValorCofins;
   vltotalcomissao := BaseComissao * (Aux/100);
   qry.Close;
   qry.SQL.Clear;
   qry.SQL.Add('update t_lancamentos_cr set');
   qry.SQL.Add('LCR_LIBCOMISSAO = 1, ');
   qry.SQL.Add('LCR_USUARIOLIBCOMISSAO = '+#39+NomeUsuario+#39+', ');
   qry.SQL.Add('LCR_DATALIBCOMISSAO = :datacredito, ');
   qry.SQL.Add('LCR_PORC_COMISSAO = :LCR_PORC_COMISSAO, ');
   qry.SQL.Add('LCR_VALOR_COMISSAO = :LCR_VALOR_COMISSAO, ');
   qry.SQL.Add('LCR_COMISSAOCR = :LCR_COMISSAOCR, ');
   qry.SQL.Add('LCR_BASECALCULOCOMISSAO = :LCR_BASECALCULOCOMISSAO, ');
   qry.SQL.Add('LCR_PISCONTRATO = :LCR_PISCONTRATO, ');
   qry.SQL.Add('LCR_COFINSCONTRATO = :LCR_COFINSCONTRATO, ');
   qry.SQL.Add('LCR_STATUS = 1 ');
   qry.SQL.Add('where LCR_LANCAMENTO = '+#39+Q_LCRComissao.FieldByName('LCR_LANCAMENTO').AsString+#39);
   qry.ParamByName('datacredito').AsDatetime := now;
   qry.ParamByName('LCR_PORC_COMISSAO').AsFloat := Aux;
   qry.ParamByName('LCR_VALOR_COMISSAO').AsFloat := vltotalcomissao;
   qry.ParamByName('LCR_COMISSAOCR').AsFloat := vltotalcomissao / Q_LCRComissao.FieldByName('LCR_NPERIODOS').AsInteger; // valor por parcela;
   qry.ParamByName('LCR_BASECALCULOCOMISSAO').AsFloat := BaseComissao;
   qry.ParamByName('LCR_PISCONTRATO').AsFloat := ValorPIS;
   qry.ParamByName('LCR_PISCONTRATO').AsFloat := ValorCOFINS;
   qry.ExecSQL;
   //DM_DI.GravaHistorico(NomeUsuario,'199','Lib.Comis.Aut.Contr.', Lancamento + ' - '+NomeUsuario);
   DM_Config.IBTransaction.CommitRetaining;
   //Application.MessageBox('Crédito Aprovado com sucesso! O contrato agora está disponível para ativação.', 'Análise de Crédito', [smbOK], smsWarning);
   qry.Close;
   Q_LCRComissao.Close;
   Freeandnil(Qry);
   Freeandnil(Q_LCRComissao);
end;

function VerificaCreditoAutomatico: boolean;
var Qry: TIBQuery;
begin
   Qry := TIBQuery.Create(nil);
   Qry.Database := DM_Config.IBDB;
   Qry.Active := false;
   Qry.SQL.Clear;
   Qry.SQL.Text := 'select EVCODIGO from T_EVENTOS where EVTIPO = 1 and EVDATAINICIO < :data and EVSTATUS = '+#39+'1'+#39+' and ((EVDATATERMINO is null) or ((EVDATATERMINO > :data) and (EVDATATERMINO is not null)))';
   Qry.ParamByName('data').AsDateTime := NOW;
   Qry.Open;
   if Qry.IsEmpty then
      VerificaCreditoAutomatico := false
   else
      VerificaCreditoAutomatico := true;
   Qry.Close;
   Freeandnil(Qry);
end;

function VerificaDigitoModulo11(Codigo : string):boolean;
var Matriz : array [1..43] of integer;   // Vetor para armazenamento do código
    Peso   : array [1..43] of integer;   // Vetor para armazenamento dos pesos
    I, Fator, SomaTotal, RestoDivisao  : Integer;
    CodigoSemDigito : String;
    Digito, DigitoCalculado : integer;
begin
  // Separa o Código e o Dígito
  CodigoSemDigito := Copy(Codigo, 1, Length(Codigo)-1);
  Digito          := StrToInt(Copy(Codigo, Length(Codigo), 1));
  // Dimensiona o Vetor com o tamanho do código
//  SetLength(Matriz, Length(CodigoSemDigito));
//  SetLength(Peso,   Length(CodigoSemDigito));
  // Define os pesos 2,3,4,5,6,7,8,9 para cada posição começando da direita para a esquerda
  Fator := 2;
  for I := Length(CodigoSemDigito) downto 1 do
    begin
      Matriz[I] := StrToInt(Copy(CodigoSemDigito, I, 1));
      Peso[I] := Fator;
      Inc(Fator);
      if Fator > 9  then
        Fator := 2;
    end;
  // Faz a multiplicação de cada posição pelo seu peso e soma ao total
  SomaTotal := 0;
  for I := 1 to Length(CodigoSemDigito) do
    SomaTotal := SomaTotal + ( Matriz[I] * Peso[I] );
  // Divide a Soma Total por 11 para pegar o resto
  RestoDivisao := (SomaTotal mod 11);
  // Calcula o dígito que é a diferença do resto para 11
  if ((RestoDivisao = 0) or (RestoDivisao = 1)) then
    DigitoCalculado := 0
  else
    DigitoCalculado := 11 - RestoDivisao;
  VerificaDigitoModulo11 := Digito = DigitoCalculado;
end;

function InsereMensagemMovimento(datamov: TDatetime; mensagem: string): boolean;
var Qry: TIBQuery;
    dtultmovfechado: TDatetime;
    inseriu: boolean;
begin
   Qry := TIBQuery.Create(nil);
   Qry.Database := DM_Config.IBDB;
   Qry.Active := false;
   Qry.SQL.Clear;
   // se datamov = 0 (não informou data, então pega próximo dia de movimento bancário em aberto
   if datamov = 0 then
      begin
         // Verifica ultimo dia de movimento fechado
         Qry.SQL.Text := 'select max(fb_datamov) from T_FECHAMENTO_BANCARIO ';
         Qry.Active := true;
         if not qry.IsEmpty then
            begin
             //  dtultmovfechado := achaproximodiautil(qry.Fields[0].AsDateTime+1);
      //         dtultmovfechado := dtultmovfechado - 1;
            end
         else
            //dtultmovfechado := achaproximodiautil(date - 1);
      end
   else
      dtultmovfechado := datamov;
   Try
      Qry.Active := false;
      Qry.SQL.Clear;
      Qry.SQL.Text := 'insert into t_mensagens_movimento (mmo_datamov, mmo_mensagem) values '+
                      '(:datamov, :mensagem)';
      Qry.ParamByName('datamov').AsDate := dtultmovfechado;
      //Qry.ParamByName('mensagem').AsBlob := 'Observações: '+#10+#13+mensagem;
      Qry.execsql;
      DM_Config.IBTransaction.CommitRetaining;
      Inseriu := true;
   Except
      Inseriu := false;
   end;
   if not inseriu then
      begin
         Try
            Qry.Active := false;
            Qry.SQL.Clear;
            Qry.SQL.Text := 'select mmo_mensagem from t_mensagens_movimento '+
                            'where mmo_datamov = :datamov ';
            Qry.ParamByName('datamov').AsDate := dtultmovfechado;
            Qry.Active := true;
            if not Qry.isempty then
               mensagem := Qry.Fieldbyname('mmo_mensagem').Asstring+#10+mensagem;
            Qry.Active := false;
            Qry.SQL.Clear;
            Qry.SQL.Text := 'update t_mensagens_movimento '+
                            'set mmo_mensagem = :mensagem '+
                            'where mmo_datamov = :datamov ';
            Qry.ParamByName('datamov').AsDate := dtultmovfechado;
            Qry.ParamByName('mensagem').AsString := mensagem;
            Qry.execsql;
            DM_Config.IBTransaction.CommitRetaining;
            InsereMensagemMovimento := true;
         Except
            InsereMensagemMovimento := false;
         end;
      end
   else
      begin
         InsereMensagemMovimento := true;
      end;
   qry.close;
   Freeandnil(qry);
end;

function getPercentual(tipo : Integer; percentual : Double): Double;
var aux : Double;
begin
  // tipo 1 converte 100% para 4%
 // tipo 2 converte 4% para 100%

  if tipo = 1 then
    Result := (4 * percentual) / 100
  else
    Result := (100 * percentual) / 4;
end;

function LiberaOFEtiqueta(CodigoUsuario: string): boolean;
var Qry: TIBQuery;
    resultado: boolean;
begin
   resultado := false;
   Qry := TIBQuery.Create(nil);
   Qry.Database := DM_Config.IBDB;
   Qry.Active := false;
   Qry.SQL.Clear;
   Qry.SQL.Text := 'select TUSCOD, TUSLOGIN, TUSLIBOFETQ from T_USUARIO '+
                   'where TUSCOD = :usuario ';
   Qry.ParamByName('usuario').AsString := CodigoUsuario;
   Qry.Active := true;
   if not Qry.IsEmpty then
      if Qry.FieldByName('TUSLIBOFETQ').AsString = '1' then
         resultado := true;
   LiberaOFEtiqueta := resultado;
end;

procedure OpenPDF(aFile : TFileName; TypeForm : Integer = SW_NORMAL);
var
  Pdir: PChar;
begin
  GetMem(pDir, 256);
  StrPCopy(pDir, aFile);
  ShellExecute(0, nil, Pchar(aFile), nil, Pdir, TypeForm);
  FreeMem(pdir, 256);
end;

end.

