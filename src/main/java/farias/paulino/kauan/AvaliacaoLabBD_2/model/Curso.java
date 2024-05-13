package farias.paulino.kauan.AvaliacaoLabBD_2.model;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Curso {
	private int codigo;
	private String nome;
	private int carga_horaria;
	private String sigla;
	private double nota_enade;
}
