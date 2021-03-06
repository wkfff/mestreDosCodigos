unit Teste.Builder.Tabela;

interface

uses
  SQL.Impl.Tabela.Builder;

type
  TCBTabelaBase= class(TBuilderTabela)
  public
    procedure AfterConstruction; override;
    procedure buildSQL; override;
  end;

  TCBTabelaComNomeApenas = class(TCBTabelaBase)
  public
    procedure buildAliasTabela; override;
    procedure buildNomeTabela; override;
  end;

  TCBTabelaComNomeEAlias = class(TCBTabelaBase)
  public
    procedure buildAliasTabela; override;
    procedure buildNomeTabela; override;
  end;


implementation

uses
  Teste.Constantes;

{ TBuilderTabelaComNomeApenas }

procedure TCBTabelaComNomeApenas.buildAliasTabela;
begin
  FObjeto.setAlias('');
end;

procedure TCBTabelaComNomeApenas.buildNomeTabela;
begin
  FObjeto.setNome(TABELA_SEM_ALIAS);
end;

{ TBuilderTabelaComNomeEAlias }

procedure TCBTabelaComNomeEAlias.buildAliasTabela;
begin
  FObjeto.setAlias(TABELA_ALIAS)
end;

procedure TCBTabelaComNomeEAlias.buildNomeTabela;
begin
  FObjeto.setNome(TABELA_COM_ALIAS);
end;


{ TCBTabelaBase }

procedure TCBTabelaBase.AfterConstruction;
begin
  inherited;
  setOtimizarPara(OTIMIZAR_PARA);
end;

procedure TCBTabelaBase.buildSQL;
begin
  inherited;

end;

end.
