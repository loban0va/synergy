object WebModule1: TWebModule1
  Actions = <
    item
      Default = True
      Name = 'DefaultHandler'
      PathInfo = '/'
      OnAction = WebModule1DefaultHandlerAction
    end
    item
      Name = 'WebActionItem1'
    end>
  Height = 230
  Width = 415
  object ADOConnection1: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=Test1234!;Persist Security Info=Tru' +
      'e;User ID=sa;Initial Catalog=TodoListDB;Data Source=192.168.31.2' +
      '01'
    Provider = 'SQLOLEDB.1'
    Left = 304
    Top = 40
  end
  object ADOQuery1: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 184
    Top = 56
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 176
    Top = 152
  end
  object DataSetProvider1: TDataSetProvider
    Left = 72
    Top = 112
  end
end
