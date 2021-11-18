unit UWeblogin_formsys_999;

interface

uses
  System.SysUtils, System.Classes, Data.DB, IBX.IBDatabase, IBX.IBCustomDataSet,
  IBX.IBQuery,Winapi.Windows,Variants,System.AnsiStrings
  ,System.JSON,MARS.Core.JSON,FireDAC.Comp.Client;
 type
 Win1252String = type AnsiString(1252);
 AnsiChar = #0..#255;
  TWebloginsys = class

  function  UsuarioValido(PUser, PSenha : string):TJSONObject;
  function  Conexao(PUser, PSenha : string):Boolean;
  function   TrocaCaracterEspecial(aTexto : string; aLimExt : boolean) : string;
  Function EnDeCripta (Texto : String; Chave: Word) : String;
  function GetDataSetAsJSON(DataSet: TDataSet): TJSONObject;
  function SomeDataset: TDataset;
    private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses UDataCclConfig,  UTools_CLX, UAcessos, UModulos;

function TWebloginsys.UsuarioValido(PUser, PSenha : string):TJSONObject;
var Resultado : boolean;
    Senha, bcSenha,NovaSenha, User, msg: string;
    qry : TIBQuery;
    qry_Acessos :TWebAcessos; qry_Modulos:TWebModulos;
    tab_WiewWebModulo:TABwebModulo;
    teste : string;
    dataweb:TJSOnObject;
    a: TJSONArray; f: TField; o: TJSOnObject;
begin
     try
        qry := TIBQuery.Create(qry);
        qry.Database := VCLDM_Config.IBDB;

        qry_Acessos := TWebAcessos.Create(qry_Acessos);
        qry_Modulos := TWebModulos.Create(qry_Modulos);
        tab_WiewWebModulo:= TABwebModulo.Create(tab_WiewWebModulo);
        a := TJSONArray.Create;

        qry.active:= False;
        qry.SQL.Clear;
        qry.SQL.Add(' SELECT TUSCOD, TUSNOME, TUSLOGIN, TUSDEPTO, TUSEMAIL, TUSATIVO, TUSEQUIPE, TUSSENHA ');
        qry.SQL.Add(' FROM   T_USUARIO ');
        qry.SQL.Add(' WHERE  TUSLOGIN = :user');
        qry.ParamByName('user').AsString:=PUser;
        qry.active:=TRUE;
         if (Not qry.Isempty) then
         begin
           User:= qry.FieldByName('TUSNOME').AsString;
           Senha:=RawByteString(qry.FieldByName('TUSSENHA').AsString);
           teste :=EnDeCripta(AllTrim(Senha) ,32);
           NovaSenha:=PadR(PSenha,10);

//           teste :=Filtra(Senha);
           //NovaSenha:=teste;
//           teste:= Criptografia( NovaSenha, False);
//
//            msg:= Senha + '|' + teste;


           //Senha:=AllTrim(bcSenha);
//           NovaSenha:=Criptografia(AllTrim(Senha), False);


           if  NovaSenha = teste then
           begin
            qry_Acessos.Close;
            qry_Acessos.PreparaQueryAcessos;
            qry_Acessos.Open;
            qry_Modulos.Close;
            qry_Modulos.PreparaQueryModulos;
            qry_Modulos.Open;
            tab_WiewWebModulo.Close;
            tab_WiewWebModulo.Open;

//             dataweb.Create(dataweb);
//             dataweb.DataSetField.Create(nil);
//             dataweb.Open;
                if qry.Fields[5].AsInteger = 1 then // Se o cadastro está ativo
              begin
                CodigoUsuario := qry.Fields[0].AsString;
                ModuloAcesso:='000';
                qry_Acessos.Edit;
                Resultado     := qry_Acessos.Locate('ACSUSUARIO;ACSMODULO', VarArrayOf([CodigoUsuario, ModuloAcesso]), [loCaseInsensitive]);
                if Resultado then
                begin

                  qry_Acessos.First;
                  dataweb := TJSOnObject.Create;

                   while not qry_Acessos.Eof do
                  begin
                     if qry_Modulos.Locate('MODCODIGO',qry_Acessos.FieldByName('ACSMODULO').AsString,[]) then
                      begin
                        tab_WiewWebModulo.Append;
                        tab_WiewWebModulo.FieldByName('MODCODIGO').AsString:=qry_Modulos.FieldByName('MODCODIGO').AsString;
                        tab_WiewWebModulo.FieldByName('MODNOME').AsString:=qry_Modulos.FieldByName('MODNOME').AsString;
                       tab_WiewWebModulo.Post;

                       dataweb.WriteStringValue(tab_WiewWebModulo.FieldValues['MODCODIGO'],tab_WiewWebModulo.FieldByName('MODCODIGO').AsString);

                                             //                       dataweb.Append;
//                       dataweb.FieldByName('MODCODIGO').AsString:=qry_Modulos.FieldByName('MODCODIGO').AsString;
//                       dataweb.Post;
                      end;
                     qry_Acessos.Next;
                  end;
                      //tab_WiewWebModulo.Active := True;
                      tab_WiewWebModulo.First;
                      while not tab_WiewWebModulo.EOF do begin
                        o := TJSOnObject.Create;
                        for f in tab_WiewWebModulo.Fields do
                          o.WriteStringValue(f.FieldName, VarToStr(f.Value));
                        a.AddElement(o);
                        tab_WiewWebModulo.Next;
                      end;

                end;

                 end;
           end;


         end;



//       bcSenha:= PadR(PSenha, 10) ;
//
//      // NovaSenha := StringofChar('*', length(bcSenha));
//        for x := 1 to length(bcSenha) do
//          NovaSenha := NovaSenha + '*';
//
//       Senha:=  Criptografia(AllTrim(novasenha), True);
//       msg:=Senha;
//        Result := msg;
      finally
      Result := TJSONObject.Create;
      Result.WriteArrayValue('Modulos',a);
      Result.WriteDateTimeValue('timestamp', Now);
      //Result.SetPairs('sasdasdasdasd');
//      UsuarioValido := Result;
      end;
end;

function TWebloginsys.SomeDataset: TDataset;
var
  LMemTable: TFDMemTable;
begin
  LMemTable := TFDMemTable.Create(nil);
  // field definition
  LMemTable.FieldDefs.Add('Firstname', ftString, 100);
  LMemTable.FieldDefs.Add('Lastname', ftString, 100);
  LMemTable.FieldDefs.Add('DateOfBirth', ftDate);
  LMemTable.CreateDataSet;
  // data
  LMemTable.AppendRecord(['Andrea', 'Magni', EncodeDate(1982, 05, 24)]);
  LMemTable.AppendRecord(['Michael', 'Schumacher', EncodeDate(1969, 1, 3)]);
  LMemTable.AppendRecord(['Sebastian', 'Vettel', EncodeDate(1987, 7, 3)]);

  Result := LMemTable;
end;



Function TWebloginsys.EnDeCripta (Texto : String; Chave: Word) : String;
var I,j: Integer; Saida,ststest,stscompfile,stscomptexto,s, c: String;
FatorPar, FatorImpar,lin: integer;
carac,tword,ascfile,pwuawe:TStringList;
testef:SmallInt;
ct:Extended;
begin
Saida := '';  { Atribuímos o valor inicial da variável como sendo uma String vazia}
 FatorPar := 2;
 FatorImpar := 3;
 carac:=TStringList.Create;
  ascfile:=TStringList.Create;
  tword:=TStringList.Create;
  pwuawe:=TStringList.Create;
  ascfile.LoadFromFile('asciiext.txt');
For I := 1 to Length (Texto) do  {Aqui criamos laço “FOR DO“ indo de 1 ao tamanho em bytes da variável a ser criptografada, atribuindo o valor numérico à variável “I”}
begin
c:=Texto[i];
carac.Add(Texto[I]);
ct:= Round((FatorPar *  ORD(Texto[i]) / FatorImpar));
if ct >= 255then
  begin
      for lin := 0 to ascfile.Count  do
       begin
          ststest:=ascfile[lin];
          stscompfile:=Copy(ststest,0,1);
          stscomptexto:=c;
          if stscomptexto = stscompfile then
          begin
            s:=Copy(ststest,3,3);
            Texto[i]:=Char(ORD(StrToInt(s)));
            Saida := Saida + Utf8ToWideString( RawByteString( UnicodeString( Win1252String( Char(ROUND((FatorPar *  ORD(Texto[I])) / FatorImpar))))));  {Este é o ponto-chave da função, pois ele após percorrer cada letra da String(Texto) toma as seguintes medidas:}
            Break
          end;
       end;
  end
   else
Saida := Saida + Utf8ToWideString( RawByteString( UnicodeString( Win1252String( Char(ROUND((FatorPar *  ORD(Texto[I])) / FatorImpar))))));  {Este é o ponto-chave da função, pois ele após percorrer cada letra da String(Texto) toma as seguintes medidas:}
 Inc(FatorPar, 2);
 Inc(FatorImpar, 2);
end;


Result := Saida;
{ Result é o termo usado para receber o resultado da nossa função e lançá-la como resultado da própria função.}
end;


  function TWebloginsys.GetDataSetAsJSON(DataSet: TDataSet): TJSONObject;
var
  f: TField;
  o: TJSOnObject;
  a: TJSONArray;
begin
  a := TJSONArray.Create;
  DataSet.Active := True;
  DataSet.First;
  while not DataSet.EOF do begin
    o := TJSOnObject.Create;
    for f in DataSet.Fields do
      o.WriteStringValue(f.FieldName, VarToStr(f.Value));
    a.AddElement(o);
    DataSet.Next;
  end;
  DataSet.Active := False;
  Result := TJSONObject.Create;
  Result.WriteArrayValue(DataSet.Name, a);
end;




function TWebloginsys.Conexao(PUser: string; PSenha: string):Boolean;
  var
   conex:Boolean;

 begin
//      DM_Config.IBDB.Connected := false;
//      DM_Config.IBDB.Params.Values['user_name'] := alltrim(PUser);
//      DM_Config.IBDB.Params.Values['password'] := alltrim(PSenha);
//      Try
//         DM_Config.IBDB.Connected := true;
//
//        if DM_Config.IBDB.Connected = true then
//           begin
//             conex := True;
//           end
//         else
//         conex := false;
//        Conexao:=conex;
//      Except
//         conex := false;
//         Conexao:=conex;
//      end;
end;

function TWebloginsys.TrocaCaracterEspecial(aTexto : string; aLimExt : boolean) : string;
const
  //Lista de caracteres especiais
  xCarEsp: array[1..38] of String = ('á', 'à', 'ã', 'â', 'ä','Á', 'À', 'Ã', 'Â', 'Ä',
                                     'é', 'è','É', 'È','í', 'ì','Í', 'Ì',
                                     'ó', 'ò', 'ö','õ', 'ô','Ó', 'Ò', 'Ö', 'Õ', 'Ô',
                                     'ú', 'ù', 'ü','Ú','Ù', 'Ü','ç','Ç','ñ','Ñ');
  //Lista de caracteres para troca
  xCarTro: array[1..38] of String = ('a', 'a', 'a', 'a', 'a','A', 'A', 'A', 'A', 'A',
                                     'e', 'e','E', 'E','i', 'i','I', 'I',
                                     'o', 'o', 'o','o', 'o','O', 'O', 'O', 'O', 'O',
                                     'u', 'u', 'u','u','u', 'u','c','C','n', 'N');
  //Lista de Caracteres Extras
  xCarExt: array[1..48] of string = ('<','>','!','@','#','$','%','¨','&','*',
                                     '(',')','_','+','=','{','}','[',']','?',
                                     ';',':',',','|','*','"','~','^','´','`',
                                     '¨','æ','Æ','ø','£','Ø','ƒ','ª','º','¿',
                                     '®','½','¼','ß','µ','þ','ý','Ý');
var
  xTexto : string;
  i : Integer;
begin
   xTexto := aTexto;
   for i:=1 to 38 do
     xTexto := StringReplace(xTexto, xCarEsp[i], xCarTro[i], [rfreplaceall]);
   //De acordo com o parâmetro aLimExt, elimina caracteres extras.
   if (aLimExt) then
     for i:=1 to 48 do
       xTexto := StringReplace(xTexto, xCarExt[i], '', [rfreplaceall]);
   Result := xTexto;
end;

end.
