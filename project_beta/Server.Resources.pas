(*
  Copyright 2016, MARS-Curiosity - REST Library

  Home: https://github.com/andrea-magni/MARS
*)
unit Server.Resources;

interface

uses
  SysUtils, Classes

  , MARS.Core.Attributes, MARS.Core.MediaType, MARS.Core.JSON, MARS.Core.Response
  , MARS.Core.URL

  , MARS.Core.Token.Resource
//, MARS.Core.Token
  , HttpApp


;

type
  [Path('syslog')]
  TSYSLOGacessos = class
  protected
  public
    [GET, Produces(TMediaType.TEXT_HTML)]
    function Splash: string;

    [POST]
    function Login([FormParam] username: string; [FormParam] password: string): TJSONObject;

    [GET, Path('loginsyslog/'),Produces(TMediaType.TEXT_XML)]
    function loginsyslog: string;

    [GET,Path('Getuserstorage/'),Produces(TMediaType.TEXT_HTML)]
     function Getuserstorage:string;
 private
     procedure E_SenhaKeyPress(Sender: TObject; var Key: Char);
  end;

  var
  NovaSenha : string;

implementation

uses
    MARS.Core.Registry, UTools_CLX, UWeblogin_formsys_999;


{ TSYSLOGacessos }

function TSYSLOGacessos.Splash: string;
var
  LStreamReader: TStreamReader;
begin
  LStreamReader := TStreamReader.Create('..\www\splash.html', TEncoding.UTF8);
  try
    Result := LStreamReader.ReadToEnd;
  finally
    LStreamReader.Free;
  end;
end;
function TSYSLOGacessos.loginsyslog: string;
var
  LStreamReader: TStreamReader;
begin
  LStreamReader := TStreamReader.Create('..\www\loginsyslog.html', TEncoding.UTF8);
  try
    Result :=LStreamReader.ReadToEnd;
  finally
    LStreamReader.Free;
  end;
end;

function TSYSLOGacessos.Login(username, password: string): TJSONObject;
var
 teste:TWebloginsys;
 datauser:string;
  LStreamReader: TStreamReader;
begin
  //LStreamReader := TStreamReader.Create('..\www\loginsyslog.html', TEncoding.UTF8);
  try
    //datauser := teste.UsuarioValido(User,Senha);
     Result := teste.UsuarioValido(username,password);
  finally
    //LStreamReader.Free;
  end;

//  Result := User +'/'+ Senha;
end;
//inicio
function TSYSLOGacessos.Getuserstorage:string;
var
  LStreamReader: TStreamReader;
begin
  LStreamReader := TStreamReader.Create('..\www\authentication.html', TEncoding.UTF8);
  try
    Result := LStreamReader.ReadToEnd;
  finally
    LStreamReader.Free;
  end;
end;

//procedures....
procedure TSYSLOGacessos.E_SenhaKeyPress(Sender: TObject; var Key: Char);
var
 msg:string;
begin
  if ((not (ORD(Key) in [48..57]))  and
      (not (ORD(Key) in [65..90]))  and
      (not (ORD(Key) in [97..122])) and
      (Key <> #8) and (Key <> #9) and (key <> #13)) then
    Key := #0
  else
    begin
      if ORD(Key) = 8 then
        Delete(NovaSenha, Length(Novasenha), 1)
      else
        begin
          if ord(key) = 13 then
            begin
              //OkInicio := False;
              if AllTrim(NovaSenha) <> '' then
                begin


                //                   if UsuarioValidoFirebird(E_Login.Text, NovaSenha) then
//                      begin
//                          if UsuarioValido(E_Login.Text, NovaSenha) then
//                            begin
//                              OkInicio := True;
//                              Close;
//                            end
//                          else
//                            if Application.MessageBox('Usuário Inválido', Application.Name,
//                                                      [smbRetry, smbCancel], smsCritical) = smbCancel then
//                              begin
//                                //Application.Terminate;
//                                Close;
//                              end
//                            else
//                              begin
//                                E_Login.Text := '';
//                                E_Senha.Text := '';
//                                E_Login.SetFocus;
//                              end;
//                      end
//                   else
//                      if Application.MessageBox('Usuário de Banco de Dados Inválido', Application.Name,
//                                                [smbRetry, smbCancel], smsCritical) = smbCancel then
//                        begin
//                          //Application.Terminate;
//                          Close;
//                        end
//                      else
//                        begin
//                          E_Login.Text := '';
//                          E_Senha.Text := '';
//                          E_Login.SetFocus;
//                        end;
                end
              else
               begin
                 Delete(NovaSenha, Length(Novasenha), 1);

                  msg:=NovaSenha;
               end;
            end
         else
            begin
              NovaSenha := NovaSenha + Key;
              Key := #42;
            end;
        end;
    end;
end;

initialization
  TMARSResourceRegistry.Instance.RegisterResource<TSYSLOGacessos>;
//  TMARSResourceRegistry.Instance.RegisterResource<Tsyslog>;
end.
