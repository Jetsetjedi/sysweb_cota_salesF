object DM_Config: TDM_Config
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 235
  Width = 423
  object IBDB: TIBDatabase
    DatabaseName = 'C:\base\syslocal.fdb'
    Params.Strings = (
      'user_name=sistemas'
      'password=inprise'
      'sql_role_name=3')
    LoginPrompt = False
    ServerType = 'IBServer'
    Left = 16
  end
  object IBTransaction: TIBTransaction
    DefaultDatabase = IBDB
    Left = 64
  end
  object Q_Update: TIBQuery
    Database = IBDB
    Transaction = IBTransaction
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 40
    Top = 112
  end
end
