package farias.paulino.kauan.AvaliacaoLabBD_2.model;

import java.time.LocalDate;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString

public class Chamada {
	private int presenca_primeira_aula;
	private int presenca_segunda_aula;
	private int presenca_terceira_aula;
	private int presenca_quarta_aula;
	private LocalDate data_aula;
	private Matricula matricula;

}
