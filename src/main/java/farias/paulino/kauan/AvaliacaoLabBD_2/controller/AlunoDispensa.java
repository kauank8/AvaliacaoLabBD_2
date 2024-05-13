package farias.paulino.kauan.AvaliacaoLabBD_2.controller;

import java.sql.SQLException;
import java.text.Normalizer;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import farias.paulino.kauan.AvaliacaoLabBD_2.model.Aluno;
import farias.paulino.kauan.AvaliacaoLabBD_2.model.Disciplina;
import farias.paulino.kauan.AvaliacaoLabBD_2.model.Dispensa;
import farias.paulino.kauan.AvaliacaoLabBD_2.persistence.DispensaDao;

@Controller
public class AlunoDispensa {

	@Autowired
	private DispensaDao dDao;

	@RequestMapping(name = "dispensaAluno", value = "/dispensaAluno", method = RequestMethod.GET)
	public ModelAndView alunoDispensaGet(ModelMap model) {
		return new ModelAndView("dispensaAluno");
	}

	@RequestMapping(name = "dispensaAluno", value = "/dispensaAluno", method = RequestMethod.POST)
	public ModelAndView alunoDispensaPost(@RequestParam Map<String, String> param, ModelMap model) {
		// Entrada
		String cmd = param.get("botao");
		String ra = param.get("ra");
		String codigo_disciplina = param.get("codigo");
		String nome_disciplina = param.get("nome_disciplina");
		String motivo = param.get("motivo");

		String saida = "";
		String erro = "";
		Dispensa dispensa = new Dispensa();
		Disciplina disciplina = new Disciplina();
		List<Dispensa> dispensas = new ArrayList<>();
		List<Disciplina> disciplinas = new ArrayList<>();

		if (cmd.equals("Solicitar Dispensas") || cmd.equals("Acompanhar Dispensas") || cmd.equals("Solicitar Dispensas")
				|| cmd.equals("Selecionar para dispensa") || cmd.equals("Confirmar") && !ra.trim().isEmpty()) {
			Aluno a = new Aluno();
			a.setRa(ra);
			dispensa.setAluno(a);
		} else {
			saida = "O RA não pode estar vazio";
			model.addAttribute("saida", saida);
			return new ModelAndView("dispensaAluno");
		}

		if (cmd.equals("Selecionar para dispensa") || cmd.equals("Confirmar")) {
			disciplina.setCodigo(Integer.parseInt(codigo_disciplina));
			disciplina.setNome(nome_disciplina);
		}
		if (cmd.equals("Confirmar")) {
			dispensa.setMotivo(motivo);
		} 

		try {
			if (cmd.contains("Solicitar Dispensas")) {
				disciplinas = listarDisciplina(dispensa);
				disciplina = null;
			}
			if (cmd.contains("Acompanhar Dispensas")) {
				dispensas = acompanharDispensa(dispensa);
				if(dispensas.isEmpty()) {
					saida = "Não possui solicitações de dispensas";
				}
				disciplina = null;
			}
			if (cmd.equals("Confirmar")) {
				if(!motivo.trim().isEmpty()) {
				dispensa.setDisciplina(disciplina);
				saida = confirmarDispensa(dispensa);
				disciplina = null;
				}
				else {
					saida = "O motivo não pode estar vazio";
					model.addAttribute("saida", saida);
					return new ModelAndView("dispensaAluno");
				}

			}
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
			dispensa = null;
		} finally {
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
			model.addAttribute("dispensa", dispensa);
			model.addAttribute("dispensas", dispensas);
			model.addAttribute("disciplinas", disciplinas);
			model.addAttribute("disciplina", disciplina);

			return new ModelAndView("dispensaAluno");
		}
	}

	private List<Dispensa> acompanharDispensa(Dispensa d) throws ClassNotFoundException, SQLException {
		List<Dispensa> list = new ArrayList<>();
		list = dDao.acompanharDispensas(d);
		return list;
	}

	private List<Disciplina> listarDisciplina(Dispensa d) throws ClassNotFoundException, SQLException {
		List<Disciplina> disciplinas = dDao.listarDisciplina(d);
		return disciplinas;
	}

	private String confirmarDispensa(Dispensa d) throws ClassNotFoundException, SQLException {
		return dDao.solicitarDispensa(d);
	}

}
