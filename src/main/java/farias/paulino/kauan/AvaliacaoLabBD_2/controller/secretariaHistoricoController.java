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
import farias.paulino.kauan.AvaliacaoLabBD_2.model.Matricula;
import farias.paulino.kauan.AvaliacaoLabBD_2.persistence.HistoricoDao;

@Controller
public class secretariaHistoricoController {
	
	@Autowired
	private HistoricoDao hDao;
	
	@RequestMapping(name = "secretariaHistorico", value = "/secretariaHistorico", method = RequestMethod.GET)
	public ModelAndView secretariaHistoricoGet(ModelMap model) {
		return new ModelAndView("secretariaHistorico");
	}
	
	@RequestMapping(name = "secretariaHistorico", value = "/secretariaHistorico", method = RequestMethod.POST)
	public ModelAndView secretariaHistoricoPost(@RequestParam Map<String, String> param, ModelMap model) {
		String cmd = param.get("botao");
		String ra = param.get("ra");
		
		// Retorno
		String saida = "";
		String erro = "";
		Aluno a = new Aluno();
		List<Matricula> matriculas = new ArrayList<>();
		
		if(cmd.contains("Buscar Historico")) {
			if (ra.trim().isEmpty()) {
				saida = "Ra em branco";
			} else {
				a.setRa(ra);
			}
		}
		
		try {
			if(cmd.contains("Buscar Historico")) {
				matriculas = buscar_historico(a);
			}
		}catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
			model.addAttribute("aluno", a);
			model.addAttribute("matriculas", matriculas);
			
			return new ModelAndView("secretariaHistorico");
		}
		
		
	}

	private List<Matricula> buscar_historico(Aluno a) throws ClassNotFoundException, SQLException {
		return hDao.buscar_historico(a);
	}
	
}
