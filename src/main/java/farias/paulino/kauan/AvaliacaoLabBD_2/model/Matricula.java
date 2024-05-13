package farias.paulino.kauan.AvaliacaoLabBD_2.model;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Matricula {
	 private Aluno aluno;
	 private int ano_semestre;
	 private double frequencia;
	 private String nota;
	 private String situacao;
	 private int quantidade_faltas ;
	 private int quantidade_presenca;
	 private Disciplina disciplina;
}
