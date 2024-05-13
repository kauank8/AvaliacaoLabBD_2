package farias.paulino.kauan.AvaliacaoLabBD_2.controller;

import java.sql.SQLException;
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
public class ConsultarMatriculaController {
	@Autowired
	private MatriculaDao mDao;

	@RequestMapping(name = "consultarMatricula", value = "/consultarMatricula", method = RequestMethod.GET)
	public ModelAndView MatriculaGet(ModelMap model) {
		return new ModelAndView("consultarMatricula");
	}

	@RequestMapping(name = "consultarMatricula", value = "/consultarMatricula", method = RequestMethod.POST)
	public ModelAndView MatriculaPost(@RequestParam Map<String, String> param, ModelMap model) {
		// Entrada
		String cmd = param.get("botao");
		String ra = param.get("ra");
	

		// Retorno
		String saida = "";
		String erro = "";
		Matricula m = new Matricula();
		List<Matricula> matriculas = new ArrayList<>();
		

		if (cmd.equals("Listar Matriculas")) {
			if (ra.trim().isEmpty()) {
				saida = "Ra em branco";
			} else {
				Aluno a = new Aluno();
				a.setRa(ra);
				m.setAluno(a);
			}
		}
		try {
			if (cmd.contains("Listar Matriculas")) {
				matriculas = listarMatricula(m);
			}
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
			m = null;
		} finally {
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
			model.addAttribute("matricula", m);
			model.addAttribute("matriculas", matriculas);

			return new ModelAndView("consultarMatricula");
		}
	}

	private List<Matricula> listarMatricula(Matricula m) throws ClassNotFoundException, SQLException {
		List<Matricula> matriculas = new ArrayList<>();
		matriculas = mDao.listarMatriculas(m);
		return matriculas;
	}

}
