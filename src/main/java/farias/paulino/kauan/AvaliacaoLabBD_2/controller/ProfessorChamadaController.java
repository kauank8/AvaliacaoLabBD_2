package farias.paulino.kauan.AvaliacaoLabBD_2.controller;

import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import farias.paulino.kauan.AvaliacaoLabBD_2.model.Aluno;
import farias.paulino.kauan.AvaliacaoLabBD_2.model.Chamada;
import farias.paulino.kauan.AvaliacaoLabBD_2.model.Disciplina;
import farias.paulino.kauan.AvaliacaoLabBD_2.model.Matricula;
import farias.paulino.kauan.AvaliacaoLabBD_2.model.Professor;
import farias.paulino.kauan.AvaliacaoLabBD_2.persistence.ProfessorDao;

@Controller
public class ProfessorChamadaController {
	@Autowired
	private ProfessorDao pDao;

	@RequestMapping(name = "professorChamada", value = "/professorChamada", method = RequestMethod.GET)
	public ModelAndView professorChamadaGet(@RequestParam Map<String, String> param, ModelMap model) {
		return new ModelAndView("professorChamada");
	}

	@RequestMapping(name = "professorChamada", value = "/professorChamada", method = RequestMethod.POST)
	public ModelAndView professorChamadaPost(@RequestParam Map<String, String> param, ModelMap model) {
		// Entrada
		String cmd = param.get("botao");
		String matricula = param.get("matricula");
		String codigo_disciplina = param.get("codigo_disciplina");
		String nome_disciplina = param.get("nome_disciplina");
		String ra_aluno = param.get("ra_aluno");
		String data_chamada = param.get("data_chamada");
		
		// Saida
		String saida = "";
		String erro = "";
		Professor professor = new Professor();
		Disciplina disciplina = new Disciplina();
		Chamada chamada = new Chamada();
		List<Disciplina> disciplinas = new ArrayList<>();
		List<Chamada> chamadas = new ArrayList<>();
		List<Matricula> matriculas = new ArrayList<>();
		String horarios[] = new String[4];
		List<Chamada> editar_chamada = new ArrayList<>();
		
		if (cmd.equals("Listar Disciplinas") || cmd.equals("Acessar") || cmd.equals("Realizar nova chamada") 
				|| cmd.equals("Confirmar chamada") || cmd.equals("Editar") || cmd.equals("Editar chamada") && !matricula.trim().isEmpty()) {
			professor.setMatricula(Integer.parseInt(matricula));
		}
		if(cmd.equals("Acessar")) {
			disciplina.setCodigo(Integer.parseInt(codigo_disciplina));
			disciplina.setNome(nome_disciplina);
		}
		if(cmd.equals("Realizar nova chamada")) {
			disciplina.setCodigo(Integer.parseInt(codigo_disciplina.trim()));
		}
		if(cmd.equals("Confirmar chamada")) {
			disciplina.setCodigo(Integer.parseInt(codigo_disciplina.trim()));
		}
		if(cmd.equals("Editar") || cmd.equals("Editar chamada")) {
			disciplina.setCodigo(Integer.parseInt(codigo_disciplina.trim()));
			chamada.setData_aula(LocalDate.parse(data_chamada));
			Matricula m = new Matricula();
			m.setDisciplina(disciplina);
			chamada.setMatricula(m);
		}
		
		

		try {
			if (cmd.equals("Listar Disciplinas")) {
				if (!matricula.trim().isEmpty()) {
					disciplinas = listarDisciplinas(professor);
					chamadas = null;
				} else {
					saida = "Matricula não pode estar vazia";
				}
			}
			if(cmd.equals("Acessar")) {
				chamadas = listar_chamadas(disciplina);
				if(chamadas.isEmpty()) {
					Matricula m = new Matricula();
					m.setDisciplina(disciplina);
					chamada.setMatricula(m);
					chamadas.add(chamada);
				}
			}
			if(cmd.equals("Realizar nova chamada")) {
				Object saidas[] = listar_alunosChamada(disciplina);
				matriculas = (List<Matricula>) saidas[0];
				horarios = lista_horarios((String) saidas[1]);
				if(matriculas.isEmpty()) {
					saida = "Não há alunos matriculados nessa turma";
				}
			}
			if(cmd.equals("Confirmar chamada") || cmd.equals("Editar chamada")) {
				Object saidas[] = listar_alunosChamada(disciplina);
				matriculas = (List<Matricula>) saidas[0];
				while(!matriculas.isEmpty()) {
					ra_aluno = matriculas.get(0).getAluno().getRa();
					
					String primeira_aula = param.get("check_"+ra_aluno+"_primeira_aula");
					String segunda_aula = param.get("check_"+ra_aluno+"_segunda_aula");
					String terceira_aula = param.get("check_"+ra_aluno+"_terceira_aula");
					String quarta_aula = param.get("check_"+ra_aluno+"_quarta_aula");
					
					if(primeira_aula == null) {
						primeira_aula = "0";
					}
					if(segunda_aula == null) {
						segunda_aula = "0";
					}
					if(terceira_aula == null) {
						terceira_aula = "0";
					}
					if(quarta_aula == null) {
						quarta_aula = "0";
					}
					
					Aluno a = new Aluno();
					a.setRa(ra_aluno);
					
					Matricula m = new Matricula();
					m.setAluno(a);
					m.setDisciplina(disciplina);
					
					chamada.setPresenca_primeira_aula(Integer.parseInt(primeira_aula));
					chamada.setPresenca_segunda_aula(Integer.parseInt(segunda_aula));
					chamada.setPresenca_terceira_aula(Integer.parseInt(terceira_aula));
					chamada.setPresenca_quarta_aula(Integer.parseInt(quarta_aula));
					
					chamada.setMatricula(m);
					if(cmd.equals("Confirmar chamada")) {
						saida = insere_chamada(chamada);
					}
					if(cmd.equals("Editar chamada")) {
						saida = atualiza_chamada(chamada);
					}
					matriculas.remove(0);
						}
					}
				if(cmd.equals("Editar")) {
					editar_chamada = editar_chamada(chamada);
					Object saidas1[] = listar_alunosChamada(disciplina);
					horarios = lista_horarios((String) saidas1[1]);
				}
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
			professor = null;

		} finally {
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
			model.addAttribute("professor", professor);
			model.addAttribute("disciplinas", disciplinas);
			model.addAttribute("chamadas", chamadas);
			model.addAttribute("matriculas", matriculas);
			model.addAttribute("horarios", horarios);
			model.addAttribute("editar_chamada", editar_chamada);
			return new ModelAndView("professorChamada");
		}

	}

	private String atualiza_chamada(Chamada chamada) throws ClassNotFoundException, SQLException {
		return pDao.atualizar_chamada(chamada);
	}

	private List<Chamada> editar_chamada(Chamada chamada) throws ClassNotFoundException, SQLException {
		return pDao.lista_editar_chamada(chamada);
	}

	private String insere_chamada(Chamada chamada) throws ClassNotFoundException, SQLException {
		
		return pDao.inserir_chamada(chamada);
	}

	private Object[] listar_alunosChamada(Disciplina disciplina) throws ClassNotFoundException, SQLException {
		return pDao.listar_alunosChamada(disciplina);
	}

	private List<Chamada> listar_chamadas(Disciplina disciplina) throws ClassNotFoundException, SQLException {
		return pDao.listar_chamada(disciplina);
	}

	private List<Disciplina> listarDisciplinas(Professor professor) throws ClassNotFoundException, SQLException {
		return pDao.listar_disciplinas(professor);
	}
	private String[] lista_horarios(String s) {
		String vt[] = s.split("/n");
		return vt;
	}
}
