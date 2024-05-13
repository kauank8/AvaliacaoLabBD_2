package farias.paulino.kauan.AvaliacaoLabBD_2.model;

import java.time.LocalDate;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString

public class Aluno {
	private String ra;
	private String cpf;
	private String nome;
	private String nome_social;
	private LocalDate data_nasc;
	private String email_pessoal;
	private String email_corporativo;
	private LocalDate conclusao_segundo_grau;
	private String instituicao_segundo_grau;
	private double pontuacao_vestibular;
	private int posicao_vestibular;
	private int ano_ingresso;
	private int semestre_ingresso;
	private int semestre_limite;
	private int ano_limite;
	private Curso curso;
	private List<Telefone> telefones;

}
