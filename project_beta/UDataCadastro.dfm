object DM_Cadastro: TDM_Cadastro
  OldCreateOrder = False
  Height = 206
  Width = 441
  object IB_Usuario: TIBDataSet
    Database = DM_Config.IBDB
    Transaction = DM_Config.IBTransaction
    BufferChunks = 1000
    CachedUpdates = False
    SelectSQL.Strings = (
      'select * from T_USUARIO')
    ParamCheck = True
    UniDirectional = False
    Left = 16
    object IB_UsuarioTUSCOD: TIBStringField
      FieldName = 'TUSCOD'
      Origin = '"T_USUARIO"."TUSCOD"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 6
    end
    object IB_UsuarioTUSSENHA: TIBStringField
      FieldName = 'TUSSENHA'
      Origin = '"T_USUARIO"."TUSSENHA"'
      Required = True
      Size = 10
    end
    object IB_UsuarioTUSLOGIN: TIBStringField
      FieldName = 'TUSLOGIN'
      Origin = '"T_USUARIO"."TUSLOGIN"'
      Required = True
      Size = 10
    end
    object IB_UsuarioTUSNOME: TIBStringField
      FieldName = 'TUSNOME'
      Origin = '"T_USUARIO"."TUSNOME"'
      Size = 30
    end
    object IB_UsuarioTUSATIVO: TIntegerField
      FieldName = 'TUSATIVO'
      Origin = '"T_USUARIO"."TUSATIVO"'
    end
    object IB_UsuarioTUSFUNCAO: TIBStringField
      FieldName = 'TUSFUNCAO'
      Origin = '"T_USUARIO"."TUSFUNCAO"'
      Size = 30
    end
    object IB_UsuarioTUSADM: TIBStringField
      FieldName = 'TUSADM'
      Origin = '"T_USUARIO"."TUSADM"'
      Size = 1
    end
    object IB_UsuarioTUSEMAIL: TIBStringField
      FieldName = 'TUSEMAIL'
      Origin = '"T_USUARIO"."TUSEMAIL"'
      Size = 60
    end
    object IB_UsuarioTUSSENHAEMAIL: TIBStringField
      FieldName = 'TUSSENHAEMAIL'
      Origin = '"T_USUARIO"."TUSSENHAEMAIL"'
    end
    object IB_UsuarioTUSLOGADO: TSmallintField
      FieldName = 'TUSLOGADO'
      Origin = '"T_USUARIO"."TUSLOGADO"'
    end
    object IB_UsuarioTUSAUDITOR: TSmallintField
      FieldName = 'TUSAUDITOR'
      Origin = '"T_USUARIO"."TUSAUDITOR"'
    end
    object IB_UsuarioTUSDEPTO: TIBStringField
      FieldName = 'TUSDEPTO'
      Origin = '"T_USUARIO"."TUSDEPTO"'
      Size = 25
    end
    object IB_UsuarioTUSVENDA: TIntegerField
      FieldName = 'TUSVENDA'
      Origin = '"T_USUARIO"."TUSVENDA"'
    end
    object IB_UsuarioTUSEQUIPE: TIntegerField
      FieldName = 'TUSEQUIPE'
      Origin = '"T_USUARIO"."TUSEQUIPE"'
    end
    object IB_UsuarioTUSAPROVA_ASI: TIntegerField
      FieldName = 'TUSAPROVA_ASI'
      Origin = '"T_USUARIO"."TUSAPROVA_ASI"'
    end
    object IB_UsuarioTUSUPERVISORASSTEC: TIntegerField
      FieldName = 'TUSUPERVISORASSTEC'
      Origin = '"T_USUARIO"."TUSUPERVISORASSTEC"'
    end
    object IB_UsuarioTUSAUTENTICAGUIA: TIntegerField
      FieldName = 'TUSAUTENTICAGUIA'
      Origin = '"T_USUARIO"."TUSAUTENTICAGUIA"'
    end
    object IB_UsuarioTUSLOGINRFWINDOWS: TIBStringField
      FieldName = 'TUSLOGINRFWINDOWS'
      Origin = '"T_USUARIO"."TUSLOGINRFWINDOWS"'
      Size = 30
    end
    object IB_UsuarioTUALERTAFINANCEIRO: TSmallintField
      FieldName = 'TUALERTAFINANCEIRO'
      Origin = '"T_USUARIO"."TUALERTAFINANCEIRO"'
    end
    object IB_UsuarioTUALERTADESENVOLVIMENTO: TIntegerField
      FieldName = 'TUALERTADESENVOLVIMENTO'
      Origin = '"T_USUARIO"."TUALERTADESENVOLVIMENTO"'
    end
    object IB_UsuarioTUSVERMETAS: TSmallintField
      FieldName = 'TUSVERMETAS'
      Origin = '"T_USUARIO"."TUSVERMETAS"'
    end
    object IB_UsuarioTUPRODUCAO: TSmallintField
      FieldName = 'TUPRODUCAO'
      Origin = '"T_USUARIO"."TUPRODUCAO"'
    end
    object IB_UsuarioTUSPRODTOTAL: TSmallintField
      FieldName = 'TUSPRODTOTAL'
      Origin = '"T_USUARIO"."TUSPRODTOTAL"'
    end
    object IB_UsuarioTUSPRODPRIOR: TSmallintField
      FieldName = 'TUSPRODPRIOR'
      Origin = '"T_USUARIO"."TUSPRODPRIOR"'
    end
    object IB_UsuarioTUSPRODMMP: TSmallintField
      FieldName = 'TUSPRODMMP'
      Origin = '"T_USUARIO"."TUSPRODMMP"'
    end
    object IB_UsuarioTUSPRODIMPRL: TSmallintField
      FieldName = 'TUSPRODIMPRL'
      Origin = '"T_USUARIO"."TUSPRODIMPRL"'
    end
    object IB_UsuarioTUSPRODMONT: TSmallintField
      FieldName = 'TUSPRODMONT'
      Origin = '"T_USUARIO"."TUSPRODMONT"'
    end
    object IB_UsuarioTUSPRODIMPCX: TSmallintField
      FieldName = 'TUSPRODIMPCX'
      Origin = '"T_USUARIO"."TUSPRODIMPCX"'
    end
    object IB_UsuarioTUSPRODRETOMAR: TSmallintField
      FieldName = 'TUSPRODRETOMAR'
      Origin = '"T_USUARIO"."TUSPRODRETOMAR"'
    end
    object IB_UsuarioTUSPRODIMPREL: TSmallintField
      FieldName = 'TUSPRODIMPREL'
      Origin = '"T_USUARIO"."TUSPRODIMPREL"'
    end
    object IB_UsuarioTUSPRODPARCIAL: TSmallintField
      FieldName = 'TUSPRODPARCIAL'
      Origin = '"T_USUARIO"."TUSPRODPARCIAL"'
    end
    object IB_UsuarioTUSPRODTROCAMQ: TSmallintField
      FieldName = 'TUSPRODTROCAMQ'
      Origin = '"T_USUARIO"."TUSPRODTROCAMQ"'
    end
    object IB_UsuarioTUSPRODPARADA: TSmallintField
      FieldName = 'TUSPRODPARADA'
      Origin = '"T_USUARIO"."TUSPRODPARADA"'
    end
    object IB_UsuarioTUSPRODCONSULTA: TSmallintField
      FieldName = 'TUSPRODCONSULTA'
      Origin = '"T_USUARIO"."TUSPRODCONSULTA"'
    end
    object IB_UsuarioTUSPRODBLOQ: TSmallintField
      FieldName = 'TUSPRODBLOQ'
      Origin = '"T_USUARIO"."TUSPRODBLOQ"'
    end
    object IB_UsuarioTUSLIBOFETQ: TSmallintField
      FieldName = 'TUSLIBOFETQ'
      Origin = '"T_USUARIO"."TUSLIBOFETQ"'
    end
  end
  object DS_Usuario: TDataSource
    DataSet = IB_Usuario
    Left = 16
    Top = 48
  end
  object DS_Modulos: TDataSource
    DataSet = IB_Modulos
    Left = 88
    Top = 47
  end
  object IB_Modulos: TIBDataSet
    Database = DM_Config.IBDB
    Transaction = DM_Config.IBTransaction
    BufferChunks = 1000
    CachedUpdates = False
    SelectSQL.Strings = (
      'select * from T_MODULOS order by MODNOME')
    ParamCheck = True
    UniDirectional = False
    Left = 88
    object IB_ModulosMODCODIGO: TIBStringField
      FieldName = 'MODCODIGO'
      Origin = '"T_MODULOS"."MODCODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 3
    end
    object IB_ModulosMODNOME: TIBStringField
      FieldName = 'MODNOME'
      Origin = '"T_MODULOS"."MODNOME"'
      Required = True
      Size = 60
    end
    object IB_ModulosMODINCLUSAO: TIBStringField
      FieldName = 'MODINCLUSAO'
      Origin = '"T_MODULOS"."MODINCLUSAO"'
      Size = 1
    end
    object IB_ModulosMODEXCLUSAO: TIBStringField
      FieldName = 'MODEXCLUSAO'
      Origin = '"T_MODULOS"."MODEXCLUSAO"'
      Size = 1
    end
    object IB_ModulosMODCONSULTA: TIBStringField
      FieldName = 'MODCONSULTA'
      Origin = '"T_MODULOS"."MODCONSULTA"'
      Size = 1
    end
    object IB_ModulosMODALTERACAO: TIBStringField
      FieldName = 'MODALTERACAO'
      Origin = '"T_MODULOS"."MODALTERACAO"'
      Size = 1
    end
    object IB_ModulosMODIMPRESSAO: TIBStringField
      FieldName = 'MODIMPRESSAO'
      Origin = '"T_MODULOS"."MODIMPRESSAO"'
      Size = 1
    end
    object IB_ModulosMODEXECUCAO: TIBStringField
      FieldName = 'MODEXECUCAO'
      Origin = '"T_MODULOS"."MODEXECUCAO"'
      Size = 1
    end
    object IB_ModulosMODLIBERACAO: TIBStringField
      FieldName = 'MODLIBERACAO'
      Origin = '"T_MODULOS"."MODLIBERACAO"'
      Size = 1
    end
  end
  object DS_Acessos: TDataSource
    DataSet = IB_Acessos
    Left = 157
    Top = 47
  end
  object IB_Acessos: TIBDataSet
    Database = DM_Config.IBDB
    Transaction = DM_Config.IBTransaction
    BufferChunks = 1000
    CachedUpdates = False
    SelectSQL.Strings = (
      'select * from T_ACESSOS')
    ParamCheck = True
    UniDirectional = False
    Left = 155
    Top = 1
    object IB_AcessosACSUSUARIO: TIBStringField
      FieldName = 'ACSUSUARIO'
      Origin = '"T_ACESSOS"."ACSUSUARIO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 6
    end
    object IB_AcessosACSSENHA: TIBStringField
      FieldName = 'ACSSENHA'
      Origin = '"T_ACESSOS"."ACSSENHA"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 10
    end
    object IB_AcessosACSMODULO: TIBStringField
      FieldName = 'ACSMODULO'
      Origin = '"T_ACESSOS"."ACSMODULO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 3
    end
    object IB_AcessosACSPERMISS: TIBStringField
      FieldName = 'ACSPERMISS'
      Origin = '"T_ACESSOS"."ACSPERMISS"'
      Required = True
      Size = 7
    end
  end
  object IB_Pesquisa: TIBQuery
    Database = DM_Config.IBDB
    Transaction = DM_Config.IBTransaction
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'SELECT TUSCOD, TUSNOME, TUSLOGIN, TUSDEPTO, TUSEMAIL, TUSATIVO, ' +
        'TUSEQUIPE, TUSSENHA'
      'FROM   T_USUARIO')
    Left = 222
    Top = 1
  end
  object DS_Pesquisa: TDataSource
    DataSet = IB_Pesquisa
    Left = 224
    Top = 47
  end
  object IB_Consulta: TIBQuery
    Database = DM_Config.IBDB
    Transaction = DM_Config.IBTransaction
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 288
    Top = 1
  end
  object DS_Consulta: TDataSource
    DataSet = IB_Consulta
    Left = 293
    Top = 48
  end
end
