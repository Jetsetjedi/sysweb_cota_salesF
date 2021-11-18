object VCLDM_Config: TVCLDM_Config
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 158
  Width = 237
  object IBDB: TIBDatabase
    Connected = True
    DatabaseName = 'C:\base\syslocal.fdb'
    Params.Strings = (
      'user_name=sistemas'
      'password=inprise'
      'sql_role_name=3')
    LoginPrompt = False
    DefaultTransaction = IBTransaction
    ServerType = 'IBServer'
    Left = 24
    Top = 8
  end
  object IBTransaction: TIBTransaction
    Active = True
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 101
    Top = 8
  end
  object Q_Update: TIBQuery
    Database = IBDB
    Transaction = IBTransaction
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 40
    Top = 80
  end
end
