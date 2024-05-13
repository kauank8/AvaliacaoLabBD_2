package farias.paulino.kauan.AvaliacaoLabBD_2.model;

import java.time.LocalDate;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Professor {
	private int matricula;
	private String nome;
	private String cpf;
	private LocalDate data_nasc;
	private String formacao_academica;
}
