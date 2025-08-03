unit WebModuleUnit1;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp, Web.WebReq,
  Datasnap.DBClient, Data.DB, Data.Win.ADODB, Vcl.Graphics, Datasnap.Provider;

type
  TWebModule1 = class(TWebModule)
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    ClientDataSet1: TClientDataSet;
    DataSetProvider1: TDataSetProvider;
    procedure WebModule1DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1WebActionItem1Action(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WebModuleClass: TComponentClass = TWebModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

procedure TWebModule1.WebModule1DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  WebModule1WebActionItem1Action(Sender, Request, Response, Handled);
  // Перенаправляем на основное действие
end;

procedure TWebModule1.WebModule1WebActionItem1Action(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  i: Integer;
  TaskName: string;
  IsCompleted: Boolean;
  Result: string;

begin
  // Запрос данных из базы
  ADOQuery1.SQL.Text := 'SELECT TaskID, TaskName, IsCompleted FROM Tasks';
  ADOQuery1.Active := True;
  DataSetProvider1.DataSet := ADOQuery1;
  ClientDataSet1.ProviderName := DataSetProvider1.Name;
  ClientDataSet1.Open;

  // Формируем HTML-код таблицы
  Response.Content := '<html>' + '<head><title>TODO List</title></head>' +
    '<body>' + '<h1>TODO List</h1>' + '<table border="1">' +
    '<tr><th>Task ID</th><th>Task Name</th><th>Completed</th></tr>';

  // Добавляем данные из ClientDataSet в таблицу
  ClientDataSet1.First;
  while not ClientDataSet1.Eof do
  begin
    TaskName := ClientDataSet1.FieldByName('TaskName').AsString;
    IsCompleted := ClientDataSet1.FieldByName('IsCompleted').AsBoolean;
    if IsCompleted then
      Result := 'checked'
    else
      Result := '';

    Response.Content := Response.Content + '<tr>' + '<td>' +
      IntToStr(ClientDataSet1.FieldByName('TaskID').AsInteger) + '</td>' +
      '<td>' + TaskName + '</td>' + '<td><input type="checkbox" ' + Result +
      ' disabled></td>' + '</tr>';

    ClientDataSet1.Next;
  end;

  Response.Content := Response.Content + '</table>' + '</body></html>';

  ClientDataSet1.Close;
  ADOQuery1.Active := False;

  Response.ContentType := 'text/html';
  Handled := True;
end;

initialization

RegisterClass(WebModuleClass);

end.
