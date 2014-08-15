package sony.model;

public class Synopsis {
	private String movieTitle;
	private String movieSynopsis;
	
	public Synopsis(String movieTitle, String movieSynopsis) {
		this.movieTitle = movieTitle;
		this.movieSynopsis = movieSynopsis;
	}
	
	public String getMovieTitle() {
		return movieTitle;
	}
	
	public void setMovieTitle(String movieTitle) {
		this.movieTitle = movieTitle;
	}
	
	public String getMovieSynopsis() {
		return movieSynopsis;
	}
	
	public void setMovieSynopsis(String movieSynopsis) {
		this.movieSynopsis = movieSynopsis;
	}
}
