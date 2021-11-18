(*
  Copyright 2016, MARS-Curiosity library

  Home: https://github.com/andrea-magni/MARS
*)
program BootstrapServerApplication;

uses
  Forms,
  Server.Forms.Main in 'Server.Forms.Main.pas' {MainForm},
  Server.Resources in 'Server.Resources.pas',
  Server.Ignition in 'Server.Ignition.pas',
  UAcessos in 'classes\weblogin\UAcessos.pas',
  UModulos in 'classes\weblogin\UModulos.pas',
  UWeblogin_formsys_999 in 'UWeblogin_formsys_999.pas',
  UDataCclConfig in 'UDataCclConfig.pas' {VCLDM_Config: TDataModule};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TVCLDM_Config, VCLDM_Config);
  Application.Run;
end.
