package farias.paulino.kauan.AvaliacaoLabBD_2.model;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Conteudo {
	private int codigo;
	private String descricao;
	private Disciplina disciplina;
}
