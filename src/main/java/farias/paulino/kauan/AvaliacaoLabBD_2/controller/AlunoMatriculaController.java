package farias.paulino.kauan.AvaliacaoLabBD_2.controller;

import java.sql.SQLException;
import java.time.LocalTime;
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
import farias.paulino.kauan.AvaliacaoLabBD_2.model.Disciplina;
import farias.paulino.kauan.AvaliacaoLabBD_2.model.Matricula;
import farias.paulino.kauan.AvaliacaoLabBD_2.persistence.MatriculaDao;

@Controller
public class AlunoMatriculaController {
	@Autowired
	private MatriculaDao mDao;

	@RequestMapping(name = "alunoMatricula", value = "/alunoMatricula", method = RequestMethod.GET)
	public ModelAndView MatriculaGet(ModelMap model) {
		return new ModelAndView("alunoMatricula");
	}

	@RequestMapping(name = "alunoMatricula", value = "/alunoMatricula", method = RequestMethod.POST)
	public ModelAndView MatriculaPost(@RequestParam Map<String, String> param, ModelMap model) {
		// Entrada
		String cmd = param.get("botao");
		String ra = param.get("ra");
		String nome_disciplina = param.get("nome");
		String dia_semana = param.get("dia_semana");
		String hora_inicio = param.get("hora_inicio");
		String hora_fim = param.get("hora_fim");
		String aulas_semanais = param.get("aulas_semanais");
		String codigo_disciplina = param.get("codigo");

		// Retorno
		String saida = "";
		String erro = "";
		Matricula m = new Matricula();
		List<Matricula> matriculas = new ArrayList<>();
		List<Disciplina> disciplinas = new ArrayList<>();

		if (cmd.equals("Listar Disciplinas Disponiveis") || cmd.equals("Matricular-se") ) {
			if (ra.trim().isEmpty()) {
				saida = "Ra em branco";
			} else {
				Aluno a = new Aluno();
				a.setRa(ra);
				m.setAluno(a);
			}
		}

		if (cmd.contains("Matricular")) {
			Disciplina d = new Disciplina();
			d.setCodigo(Integer.parseInt(codigo_disciplina));
			d.setAulas_semanais(Integer.parseInt(aulas_semanais));
			d.setDia_semana(dia_semana);
			d.setHora_inicio(LocalTime.parse(hora_inicio));
			d.setHora_fim(LocalTime.parse(hora_fim));
			d.setNome(nome_disciplina);
			m.setDisciplina(d);
		}
		try {
			if (cmd.contains("Listar Disciplinas")) {
				disciplinas = listarDisciplinas(m);
				if (disciplinas.isEmpty()) {
					saida = "Ra Inexistente";
				}
			}
			if (cmd.contains("Matricular")) {
				saida = inserirMatricula(m);
			}
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
			m = null;
		} finally {
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
			model.addAttribute("matricula", m);
			model.addAttribute("matriculas", matriculas);
			model.addAttribute("disciplinas", disciplinas);

			return new ModelAndView("alunoMatricula");
		}
	}

	private String inserirMatricula(Matricula m) throws ClassNotFoundException, SQLException {
		String saida = mDao.inserir(m);
		return saida;
	}

	private List<Disciplina> listarDisciplinas(Matricula m) throws ClassNotFoundException, SQLException {
		List<Disciplina> lista = new ArrayList<>();
		lista = mDao.listarDisciplinas(m);
		return lista;
	}

}
