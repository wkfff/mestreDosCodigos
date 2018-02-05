unit SQL.Builder.Select;

interface

uses
  SQL.Intf.Builder,
  SQL.Intf.Select,
  SQL.Impl.Builder,
  SQL.Impl.Director;

type
  IBuilderSelect = interface(IBuilder<ISQLSelect>)
    ['{ED9BF74D-D4F1-4118-8E42-48E775E85161}']
    procedure buildCampo;
    procedure buildJuncao;
    procedure buildWhere;
  end;

  TDirectorSelect = class(TDirector<IBuilderSelect, ISQLSelect>)
  public
    procedure Construir; override;
  end;

  TBuilderSelect = class(TBuilder<ISQLSelect>, IBuilderSelect)
  public
    class function New: IBuilderSelect;
    procedure ConstruirNovaInstancia; override;
    procedure buildCampo; virtual; abstract;
    procedure buildSelect; virtual; abstract;
    procedure buildJuncao; virtual; abstract;
    procedure buildWhere; virtual; abstract;
  end;

  TBuilderSelectSimples = class(TBuilderSelect)
  public
    procedure buildCampo; override;
    procedure buildJuncao; override;
    procedure buildWhere; override;
  end;

implementation

uses
  SQL.Constantes,
  Teste.Constantes,
  SQL.Intf.Director,
  SQL.Intf.Fabrica,
  SQL.Intf.Coluna,
  SQL.Intf.Juncao,
  SQL.Intf.Condicao,
  SQL.Impl.Fabrica,

  SQL.Builder.Juncao,
  SQL.Builder.Coluna;

{ TBuilderSelect }

procedure TBuilderSelect.ConstruirNovaInstancia;
var
  _fabrica: IFabrica;
begin
  _fabrica := TFabrica.New(SQL_TIPO_PADRAO);

  FObjeto := _fabrica.Select;
end;

class function TBuilderSelect.New: IBuilderSelect;
begin
  result := Create;
end;

{ TDirectorSelect }

procedure TDirectorSelect.Construir;
begin
  FBuilder.ConstruirNovaInstancia;
  FBuilder.buildCampo;
  FBuilder.buildJuncao;
  FBuilder.buildWhere;
  FObjeto := FBuilder.getObjeto
end;

{ TBuilderSelectSimples }

procedure TBuilderSelectSimples.buildCampo;
var
  _director: IDirector<IBuilderColuna, ISQLColuna>;
  _builder: IBuilderColuna;
begin
  _builder := TBuilderColunaSimples.New;
  _director := TDirectorColuna.New;
  _director.setBuilder(_builder);
  _director.Construir;

  FObjeto.addColuna(_director.getObjetoPronto);
  FObjeto.addColuna(_director.getObjetoPronto);
  FObjeto.addColuna(_director.getObjetoPronto);
  FObjeto.addColuna(_director.getObjetoPronto);
end;

procedure TBuilderSelectSimples.buildJuncao;
var
  _director: IDirector<IBuilderJuncao, ISQLJuncao>;
  _builder: IBuilderJuncao;
begin
  _builder := TBuilderJuncaoApenasTabela.New;
  _director := TDirectorJuncao.New;
  _director.setBuilder(_builder);
  _director.Construir;

  FObjeto.addJuncao(_director.getObjetoPronto);
  FObjeto.addJuncao(_director.getObjetoPronto);
  FObjeto.addJuncao(_director.getObjetoPronto);
  FObjeto.addJuncao(_director.getObjetoPronto);
end;

procedure TBuilderSelectSimples.buildWhere;
begin

end;

end.
