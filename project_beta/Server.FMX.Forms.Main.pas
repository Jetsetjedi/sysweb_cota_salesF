(*
  Copyright 2016, MARS-Curiosity - REST Library

  Home: https://github.com/andrea-magni/MARS
*)
unit Server.FMX.Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, FMX.Layouts, System.Actions, FMX.ActnList
  , MARS.http.Server.Indy, FireDAC.Phys.IBDef, FireDAC.Stan.Intf, FireDAC.Phys,
  FireDAC.Phys.IBBase, FireDAC.Phys.IB
;
const
 ArqConfig  = 'SYSLOGCFG.INI';

type
  TMainForm = class(TForm)
    MainActionList: TActionList;
    StartServerAction: TAction;
    StopServerAction: TAction;
    Layout1: TLayout;
    PortNumberEdit: TEdit;
    Label1: TLabel;
    StartButton: TButton;
    StopButton: TButton;
    Stsbarsys: TStatusBar;
    Lblinfosys: TLabel;
    Lbltt: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure StartServerActionExecute(Sender: TObject);
    procedure StopServerActionExecute(Sender: TObject);
    procedure StartServerActionUpdate(Sender: TObject);
    procedure StopServerActionUpdate(Sender: TObject);
    procedure PortNumberEditChange(Sender: TObject);
    procedure Carregainfosys;

  private
    FServer: TMARShttpServerIndy;
  public
  end;

var
  MainForm: TMainForm;
  //vars configuração do sistema
  Copyright ,
  StartPath :string;

  //fim vars configuração.

implementation

{$R *.fmx}
{$R *.Windows.fmx MSWINDOWS}

uses
  Web.HttpApp
  , MARS.Core.URL, MARS.Core.Engine
  , Server.Ignition, UDataConfig
  , UTools_CLX;



procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DM_Config.IBDB.Connected:=False;
  StopServerAction.Execute;
end;

procedure TMainForm.FormCreate(Sender: TObject);

begin
   PortNumberEdit.Text := TServerEngine.Default.Port.ToString;
   //abre o servidor web e popula os campos da tela
   Carregainfosys;

  StartServerAction.Execute;
end;

procedure TMainForm.PortNumberEditChange(Sender: TObject);
begin
  TServerEngine.Default.Port := StrToInt(PortNumberEdit.Text);
end;

procedure TMainForm.StartServerActionExecute(Sender: TObject);
begin
  // http server implementation
  FServer := TMARShttpServerIndy.Create(TServerEngine.Default);
  try
    FServer.DefaultPort := TServerEngine.Default.Port;
    FServer.Active := True;
  except
    FServer.Free;
    raise;
  end;
end;

procedure TMainForm.StartServerActionUpdate(Sender: TObject);
begin
  StartServerAction.Enabled := (FServer = nil) or (FServer.Active = False);
end;

procedure TMainForm.StopServerActionExecute(Sender: TObject);
begin
  FServer.Active := False;
  FreeAndNil(FServer);
end;

procedure TMainForm.StopServerActionUpdate(Sender: TObject);
begin
  StopServerAction.Enabled := Assigned(FServer) and (FServer.Active = True);
end;
// Jether 08/10 abrindo o servidor com dados Syscontrol-syslog
procedure TMainForm.Carregainfosys;
var
 localtrabalho:string;
begin
   // verifica tipo de trabalho
   StartPath := ExtractFilePath(ParamStr(0));
  if StartPath[Length(StartPath)] <> '\' then
    StartPath := StartPath + '\';
   localtrabalho:= AllTrim(verificaini(StartPath + ArqConfig, 'Interbase',  'ServidorBanco', ServidorBanco,              'LER'));
   if(localtrabalho = '127.0.0.1')then
   begin
    Lbltt.Text:=localtrabalho +'   ' +'Em Desenvolvimento';
   end;
   Copyright  := '©' + ALLTRIM(verificaini(StartPath + ArqConfig, 'Software', 'Copyright',    '1997 -'+ AnoVersao + ' Syscontrol Automação por Código de Barras', 'LER'));
   Lblinfosys.Text:=Copyright;
   end;

end.
