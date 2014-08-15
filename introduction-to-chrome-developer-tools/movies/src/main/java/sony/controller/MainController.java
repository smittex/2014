package sony.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import sony.model.Synopsis;
import sony.service.MovieService;

@Controller
public class MainController {

	@Autowired
	MovieService movieService;
	
	@RequestMapping(value="synopsis", method=RequestMethod.GET, produces="application/json")
    public @ResponseBody Synopsis getSynopsis(@RequestParam(value="movieId", required=true) String movieId) {
    	return movieService.getSynopsis(movieId);
    }

}
