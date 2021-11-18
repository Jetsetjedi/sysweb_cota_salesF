object DM_Frm027: TDM_Frm027
  OldCreateOrder = False
  Left = 347
  Top = 245
  Height = 255
  Width = 500
  object IBQ_OFConferir: TIBQuery
    Database = DM_Config.IBDB
    Transaction = DM_Config.IBTransaction
    OnCalcFields = IBQ_OFConferirCalcFields
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      
        'select OF_COD, OF_PRIORIDADE, OF_RAZAOFAT , OF_PEDIDO, OF_TRANSP' +
        'ORTADORA, OF_DATA, OF_PREVISAOFAT, OF_FATURAMENTO,'
      'OF_LIBERASEPARACAO, OF_LIBSEP_USUARIO, OF_LIBSEP_DATAHORA '
      'from T_ORDEM_FATURA_COMERCIAL'
      'where OF_FATURAMENTO = '#39'2'#39' or '
      '          OF_FATURAMENTO = '#39'7'#39' or'
      '           OF_FATURAMENTO = '#39'6'#39
      'order by OF_PREVISAOFAT, OF_PRIORIDADE asc')
    Left = 203
    Top = 14
    object IBQ_OFConferirOF_COD: TIBStringField
      FieldName = 'OF_COD'
      Origin = 'T_ORDEM_FATURA_COMERCIAL.OF_COD'
      Required = True
      Size = 9
    end
    object IBQ_OFConferirOF_PRIORIDADE: TIBStringField
      FieldName = 'OF_PRIORIDADE'
      Origin = 'T_ORDEM_FATURA_COMERCIAL.OF_PRIORIDADE'
      Size = 3
    end
    object IBQ_OFConferirOF_RAZAOFAT: TIBStringField
      FieldName = 'OF_RAZAOFAT'
      Origin = 'T_ORDEM_FATURA_COMERCIAL.OF_RAZAOFAT'
      Size = 60
    end
    object IBQ_OFConferirOF_ITEM: TStringField
      FieldKind = fkCalculated
      FieldName = 'OF_ITEM'
      Calculated = True
    end
    object IBQ_OFConferirOF_SERIEITEM: TStringField
      FieldKind = fkCalculated
      FieldName = 'OF_SERIEITEM'
      Calculated = True
    end
    object IBQ_OFConferirOF_PREVISAOFAT: TDateTimeField
      FieldName = 'OF_PREVISAOFAT'
      Origin = 'T_ORDEM_FATURA_COMERCIAL.OF_PREVISAOFAT'
    end
    object IBQ_OFConferirSituacao: TStringField
      FieldKind = fkCalculated
      FieldName = 'Situacao'
      Size = 22
      Calculated = True
    end
    object IBQ_OFConferirOF_FATURAMENTO: TIBStringField
      FieldName = 'OF_FATURAMENTO'
      Origin = 'T_ORDEM_FATURA_COMERCIAL.OF_FATURAMENTO'
      Size = 1
    end
    object IBQ_OFConferirOF_TRANSPORTADORA: TIBStringField
      FieldName = 'OF_TRANSPORTADORA'
      Origin = 'T_ORDEM_FATURA_COMERCIAL.OF_TRANSPORTADORA'
      Size = 60
    end
    object IBQ_OFConferirOF_PEDIDO: TIBStringField
      FieldName = 'OF_PEDIDO'
      Origin = 'T_ORDEM_FATURA_COMERCIAL.OF_PEDIDO'
      Size = 30
    end
    object IBQ_OFConferirOF_LIBERASEPARACAO: TIBStringField
      FieldName = 'OF_LIBERASEPARACAO'
      Origin = 'T_ORDEM_FATURA_COMERCIAL.OF_LIBERASEPARACAO'
      Size = 1
    end
    object IBQ_OFConferirOF_LIBSEP_USUARIO: TIBStringField
      FieldName = 'OF_LIBSEP_USUARIO'
      Origin = 'T_ORDEM_FATURA_COMERCIAL.OF_LIBSEP_USUARIO'
      Size = 6
    end
    object IBQ_OFConferirOF_LIBSEP_DATAHORA: TDateTimeField
      FieldName = 'OF_LIBSEP_DATAHORA'
      Origin = 'T_ORDEM_FATURA_COMERCIAL.OF_LIBSEP_DATAHORA'
    end
    object IBQ_OFConferirOF_DATA: TDateTimeField
      FieldName = 'OF_DATA'
      Origin = 'T_ORDEM_FATURA_COMERCIAL.OF_DATA'
    end
  end
  object IBQ_ItemOF: TIBQuery
    Database = DM_Config.IBDB
    Transaction = DM_Config.IBTransaction
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'select OF_PRODCOD, OF_PRODDESCHARDR '
      'from T_PRODUTO_ORDEM_FATURA_COM'
      'where OF_OFCOD =:CODIGOOF')
    Left = 279
    Top = 14
    ParamData = <
      item
        DataType = ftString
        Name = 'CODIGOOF'
        ParamType = ptUnknown
      end>
    object IBQ_ItemOFOF_PRODCOD: TIBStringField
      FieldName = 'OF_PRODCOD'
      Origin = 'T_PRODUTO_ORDEM_FATURA_COM.OF_PRODCOD'
      Required = True
      Size = 6
    end
    object IBQ_ItemOFOF_PRODDESCHARDR: TIBStringField
      FieldName = 'OF_PRODDESCHARDR'
      Origin = 'T_PRODUTO_ORDEM_FATURA_COM.OF_PRODDESCHARDR'
      Size = 120
    end
  end
  object DtS_QOFConferir: TDataSource
    DataSet = IBQ_OFConferir
    Left = 203
    Top = 63
  end
  object IBQ_SerieItem: TIBQuery
    Database = DM_Config.IBDB
    Transaction = DM_Config.IBTransaction
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'select NUMSERIE'
      ' from T_SERIE_PRODUTO_ESTOQUE'
      'where OF_Saida =:CODIGOOF')
    Left = 355
    Top = 14
    ParamData = <
      item
        DataType = ftString
        Name = 'CODIGOOF'
        ParamType = ptUnknown
      end>
    object IBQ_SerieItemNUMSERIE: TIBStringField
      FieldName = 'NUMSERIE'
      Origin = 'T_SERIE_PRODUTO_ESTOQUE.NUMSERIE'
      Required = True
    end
  end
  object Dts_QItemOF: TDataSource
    DataSet = IBQ_ItemOF
    Left = 279
    Top = 63
  end
  object IBQ_Etiqueta: TIBQuery
    Database = DM_Config.IBDB
    Transaction = DM_Config.IBTransaction
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      
        'select Distinct CX_OF, CX_NOTASAIDA, ICX_NUM, ICX_PROD, ICX_NF, ' +
        ' TPRDESCFATURA'
      
        'from T_ORDEM_FATURA_COMERCIAL, T_CAIXA_SEPARACAO,  T_ITEM_CAIXA_' +
        'SEPARACAO, T_PRODUTO'
      'where (CX_OF =:CODIGOOF) and '
      '          (CX_OF= ICX_OF) and'
      
        '          ((OF_COD=CX_OF) and ((OF_FATURAMENTO = '#39'4'#39') OR (OF_FAT' +
        'URAMENTO = '#39'5'#39'))) AND'
      '           (TPRCODPRODSYS=ICX_PROD) '
      'Order by ICX_NUM, ICX_PROD ')
    Left = 143
    Top = 112
    ParamData = <
      item
        DataType = ftString
        Name = 'CODIGOOF'
        ParamType = ptUnknown
      end>
    object IBQ_EtiquetaCX_OF: TIBStringField
      FieldName = 'CX_OF'
      Origin = 'T_CAIXA_SEPARACAO.CX_OF'
      Required = True
      Size = 9
    end
    object IBQ_EtiquetaCX_NOTASAIDA: TIBStringField
      FieldName = 'CX_NOTASAIDA'
      Origin = 'T_CAIXA_SEPARACAO.CX_NOTASAIDA'
      Size = 6
    end
    object IBQ_EtiquetaICX_NUM: TIBStringField
      FieldName = 'ICX_NUM'
      Origin = 'T_ITEM_CAIXA_SEPARACAO.ICX_NUM'
      Size = 4
    end
    object IBQ_EtiquetaICX_PROD: TIBStringField
      FieldName = 'ICX_PROD'
      Origin = 'T_ITEM_CAIXA_SEPARACAO.ICX_PROD'
      Required = True
      Size = 6
    end
    object IBQ_EtiquetaICX_NF: TIBStringField
      FieldName = 'ICX_NF'
      Origin = 'T_ITEM_CAIXA_SEPARACAO.ICX_NF'
      Size = 10
    end
    object IBQ_EtiquetaTPRDESCFATURA: TIBStringField
      FieldName = 'TPRDESCFATURA'
      Origin = 'T_PRODUTO.TPRDESCFATURA'
      Size = 120
    end
  end
  object DS_Etiqueta: TDataSource
    DataSet = IBQ_Etiqueta
    Left = 143
    Top = 190
  end
  object IBQ_ImprimeETQ: TIBQuery
    Database = DM_Config.IBDB
    Transaction = DM_Config.IBTransaction
    OnCalcFields = IBQ_ImprimeETQCalcFields
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      
        'select Distinct OF_CODCLIENT, OF_PLANTACLIENT, OF_ENDENT, OF_NUM' +
        'ENT, OF_COMPLENT, OF_BAIRROENT, OF_CIDADEENT, OF_UFENT, OF_CEPEN' +
        'T, OF_TRANSPORTADORA, TCLCOD, TCLRAZAO, CX_OF, CX_NUM, CX_NOTASA' +
        'IDA, CX_PESO_BRUTO, CX_PESO_LIQ, CX_ITENS, ICX_PROD, ICX_ITENS, ' +
        'TPRDESCFATURA,'
      ' OF_PRDESCRNF'
      
        'from T_ORDEM_FATURA_COMERCIAL, T_CAIXA_SEPARACAO,  T_ITEM_CAIXA_' +
        'SEPARACAO, T_PRODUTO, T_CLIENTES,  T_PRODUTO_ORDEM_FATURA_COM')
    Left = 239
    Top = 112
    object IBQ_ImprimeETQDescricaoEtiqueta: TStringField
      DisplayWidth = 600
      FieldKind = fkCalculated
      FieldName = 'DescricaoEtiqueta'
      Size = 300
      Calculated = True
    end
    object IBQ_ImprimeETQOF_CODCLIENT: TIBStringField
      FieldName = 'OF_CODCLIENT'
      Origin = 'T_ORDEM_FATURA_COMERCIAL.OF_CODCLIENT'
      Size = 12
    end
    object IBQ_ImprimeETQOF_PLANTACLIENT: TIntegerField
      FieldName = 'OF_PLANTACLIENT'
      Origin = 'T_ORDEM_FATURA_COMERCIAL.OF_PLANTACLIENT'
    end
    object IBQ_ImprimeETQOF_ENDENT: TIBStringField
      FieldName = 'OF_ENDENT'
      Origin = 'T_ORDEM_FATURA_COMERCIAL.OF_ENDENT'
      Size = 40
    end
    object IBQ_ImprimeETQOF_NUMENT: TIBStringField
      FieldName = 'OF_NUMENT'
      Origin = 'T_ORDEM_FATURA_COMERCIAL.OF_NUMENT'
      Size = 10
    end
    object IBQ_ImprimeETQOF_COMPLENT: TIBStringField
      FieldName = 'OF_COMPLENT'
      Origin = 'T_ORDEM_FATURA_COMERCIAL.OF_COMPLENT'
      Size = 15
    end
    object IBQ_ImprimeETQOF_BAIRROENT: TIBStringField
      FieldName = 'OF_BAIRROENT'
      Origin = 'T_ORDEM_FATURA_COMERCIAL.OF_BAIRROENT'
    end
    object IBQ_ImprimeETQOF_CIDADEENT: TIBStringField
      FieldName = 'OF_CIDADEENT'
      Origin = 'T_ORDEM_FATURA_COMERCIAL.OF_CIDADEENT'
      Size = 40
    end
    object IBQ_ImprimeETQOF_UFENT: TIBStringField
      FieldName = 'OF_UFENT'
      Origin = 'T_ORDEM_FATURA_COMERCIAL.OF_UFENT'
    end
    object IBQ_ImprimeETQOF_CEPENT: TIBStringField
      FieldName = 'OF_CEPENT'
      Origin = 'T_ORDEM_FATURA_COMERCIAL.OF_CEPENT'
      Size = 10
    end
    object IBQ_ImprimeETQOF_TRANSPORTADORA: TIBStringField
      FieldName = 'OF_TRANSPORTADORA'
      Origin = 'T_ORDEM_FATURA_COMERCIAL.OF_TRANSPORTADORA'
      Size = 60
    end
    object IBQ_ImprimeETQTCLCOD: TIBStringField
      FieldName = 'TCLCOD'
      Origin = 'T_CLIENTES.TCLCOD'
      Required = True
      Size = 12
    end
    object IBQ_ImprimeETQTCLRAZAO: TIBStringField
      FieldName = 'TCLRAZAO'
      Origin = 'T_CLIENTES.TCLRAZAO'
      Size = 60
    end
    object IBQ_ImprimeETQCX_OF: TIBStringField
      FieldName = 'CX_OF'
      Origin = 'T_CAIXA_SEPARACAO.CX_OF'
      Required = True
      Size = 9
    end
    object IBQ_ImprimeETQCX_NUM: TIBStringField
      FieldName = 'CX_NUM'
      Origin = 'T_CAIXA_SEPARACAO.CX_NUM'
      Required = True
      Size = 4
    end
    object IBQ_ImprimeETQCX_NOTASAIDA: TIBStringField
      FieldName = 'CX_NOTASAIDA'
      Origin = 'T_CAIXA_SEPARACAO.CX_NOTASAIDA'
      Size = 6
    end
    object IBQ_ImprimeETQCX_PESO_BRUTO: TFloatField
      FieldName = 'CX_PESO_BRUTO'
      Origin = 'T_CAIXA_SEPARACAO.CX_PESO_BRUTO'
    end
    object IBQ_ImprimeETQCX_PESO_LIQ: TFloatField
      FieldName = 'CX_PESO_LIQ'
      Origin = 'T_CAIXA_SEPARACAO.CX_PESO_LIQ'
    end
    object IBQ_ImprimeETQCX_ITENS: TIntegerField
      FieldName = 'CX_ITENS'
      Origin = 'T_CAIXA_SEPARACAO.CX_ITENS'
    end
    object IBQ_ImprimeETQICX_PROD: TIBStringField
      FieldName = 'ICX_PROD'
      Origin = 'T_ITEM_CAIXA_SEPARACAO.ICX_PROD'
      Required = True
      Size = 6
    end
    object IBQ_ImprimeETQICX_ITENS: TIntegerField
      FieldName = 'ICX_ITENS'
      Origin = 'T_ITEM_CAIXA_SEPARACAO.ICX_ITENS'
    end
    object IBQ_ImprimeETQTPRDESCFATURA: TIBStringField
      FieldName = 'TPRDESCFATURA'
      Origin = 'T_PRODUTO.TPRDESCFATURA'
      Size = 120
    end
    object IBQ_ImprimeETQOF_PRDESCRNF: TIBStringField
      FieldName = 'OF_PRDESCRNF'
      Origin = 'T_PRODUTO_ORDEM_FATURA_COM.OF_PRDESCRNF'
      Size = 20002
    end
  end
  object IBQ_UltimaCaixa: TIBQuery
    Database = DM_Config.IBDB
    Transaction = DM_Config.IBTransaction
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'select MAX(CX_NUM)'
      'from T_CAIXA_SEPARACAO')
    Left = 423
    Top = 16
    object IBQ_UltimaCaixaMAX: TIBStringField
      FieldName = 'MAX'
      Size = 4
    end
  end
  object IBQ_Caixa: TIBQuery
    Database = DM_Config.IBDB
    Transaction = DM_Config.IBTransaction
    BufferChunks = 1000
    CachedUpdates = False
    Left = 32
    Top = 16
  end
  object IBQ_ItemCaixa: TIBQuery
    Database = DM_Config.IBDB
    Transaction = DM_Config.IBTransaction
    BufferChunks = 1000
    CachedUpdates = False
    Left = 104
    Top = 16
  end
  object IBQ_SerieEstoque: TIBQuery
    Database = DM_Config.IBDB
    Transaction = DM_Config.IBTransaction
    BufferChunks = 1000
    CachedUpdates = False
    Left = 408
    Top = 120
  end
  object IBQ_OFEtiqueta: TIBQuery
    Database = DM_Config.IBDB
    Transaction = DM_Config.IBTransaction
    OnCalcFields = IBQ_OFConferirCalcFields
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      
        'select distinct OF_COD, OF_PRIORIDADE, OF_RAZAOFAT, OF_PREVISAOF' +
        'AT'
      'from T_ORDEM_FATURA_COMERCIAL, T_CAIXA_SEPARACAO'
      
        'where ((OF_FATURAMENTO = '#39'4'#39') OR ((OF_FATURAMENTO = '#39'5'#39' ) AND (C' +
        'X_OF=OF_COD)'
      'order by OF_PREVISAOFAT, OF_PRIORIDADE')
    Left = 35
    Top = 126
    object IBQ_OFEtiquetaOF_COD: TIBStringField
      FieldName = 'OF_COD'
      Origin = 'T_ORDEM_FATURA_COMERCIAL.OF_COD'
      Required = True
      Size = 9
    end
    object IBQ_OFEtiquetaOF_PRIORIDADE: TIBStringField
      FieldName = 'OF_PRIORIDADE'
      Origin = 'T_ORDEM_FATURA_COMERCIAL.OF_PRIORIDADE'
      Size = 3
    end
    object IBQ_OFEtiquetaOF_RAZAOFAT: TIBStringField
      FieldName = 'OF_RAZAOFAT'
      Origin = 'T_ORDEM_FATURA_COMERCIAL.OF_RAZAOFAT'
      Size = 60
    end
    object IBQ_OFEtiquetaOF_PREVISAOFAT: TDateTimeField
      FieldName = 'OF_PREVISAOFAT'
      Origin = 'T_ORDEM_FATURA_COMERCIAL.OF_PREVISAOFAT'
    end
  end
  object DS_OFEtiqueta: TDataSource
    DataSet = IBQ_OFEtiqueta
    Left = 67
    Top = 183
  end
  object Qry_AlteraOF: TIBQuery
    Database = DM_Config.IBDB
    Transaction = DM_Config.IBTransaction
    BufferChunks = 1000
    CachedUpdates = False
    Left = 38
    Top = 72
  end
  object IBQ_ItensFaltantes: TIBQuery
    Database = DM_Config.IBDB
    Transaction = DM_Config.IBTransaction
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'SELECT tprdescfatura, numserie'
      'FROM t_serie_produto_estoque, t_produto'
      'WHERE'
      '    produto = tprcodprodsys'
      'AND datasaida IS NULL'
      'AND OF_SAIDA =  :NUM_OF'
      ''
      '')
    Left = 238
    Top = 168
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'NUM_OF'
        ParamType = ptUnknown
      end>
    object IBQ_ItensFaltantesTPRDESCFATURA: TIBStringField
      FieldName = 'TPRDESCFATURA'
      Origin = 'T_PRODUTO.TPRDESCFATURA'
      Size = 120
    end
    object IBQ_ItensFaltantesNUMSERIE: TIBStringField
      FieldName = 'NUMSERIE'
      Origin = 'T_SERIE_PRODUTO_ESTOQUE.NUMSERIE'
      Required = True
    end
  end
  object IBQ_PecasFaltantes: TIBQuery
    Database = DM_Config.IBDB
    Transaction = DM_Config.IBTransaction
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'SELECT tprdescfatura, qtdseparada - qtdlida as numserie'
      'FROM t_caixa_produto_estoque, t_produto'
      'WHERE'
      '    produto = tprcodprodsys'
      'AND QTDLIDA < QTDSEPARADA'
      'AND OF_SAIDA =  :NUM_OF'
      ''
      '')
    Left = 342
    Top = 168
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'NUM_OF'
        ParamType = ptUnknown
      end>
    object IBQ_PecasFaltantesTPRDESCFATURA: TIBStringField
      FieldName = 'TPRDESCFATURA'
      Origin = 'T_PRODUTO.TPRDESCFATURA'
      Size = 120
    end
    object IBQ_PecasFaltantesNUMSERIE: TFloatField
      FieldName = 'NUMSERIE'
    end
  end
end
