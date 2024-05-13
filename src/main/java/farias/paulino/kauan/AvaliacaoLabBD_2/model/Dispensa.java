package farias.paulino.kauan.AvaliacaoLabBD_2.model;

import java.time.LocalDate;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Dispensa {
	private int codigo;
	private String motivo;
	private LocalDate data_solicitacao;
	private String status;
	private Aluno aluno;
	private Disciplina disciplina;
}
