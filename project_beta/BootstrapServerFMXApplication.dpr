(*
  Copyright 2016, MARS-Curiosity - REST Library

  Home: https://github.com/andrea-magni/MARS
*)
program BootstrapServerFMXApplication;

uses
  System.StartUpCopy,
  FMX.Forms,
  Server.FMX.Forms.Main in 'Server.FMX.Forms.Main.pas' {MainForm},
  Server.Ignition in 'Server.Ignition.pas',
  Server.Resources in 'Server.Resources.pas',
  UDataConfig in 'UDataConfig.pas' {DM_Config: TDataModule},
  UTools_Clx in 'UTools_Clx.pas',
  UWeblogin_formsys_999 in 'UWeblogin_formsys_999.pas',
  UDataCadastro in 'UDataCadastro.pas' {DM_Cadastro: TDataModule},
  UAcessos in 'classes\weblogin\UAcessos.pas',
  UModulos in 'classes\weblogin\UModulos.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TDM_Config, DM_Config);
  Application.CreateForm(TDM_Cadastro, DM_Cadastro);
  Application.Run;
end.
