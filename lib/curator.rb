class Curator
  attr_reader :artists, :photographs

  def initialize
    @artists = []
    @photographs = []
  end

  def add_photograph(photograph)
    @photographs << photograph
  end

  def add_artist(artist)
    @artists << artist
  end

  def find_artist_by_id(id)
    @artists.find {|artist| artist.id == id}
  end

  def find_photographs_by_artist(artist)
    @photographs.select {|photo| photo.artist_id == artist.id}
  end

  def artists_with_multiple_photographs
    artists = @photographs.group_by {|photograph| photograph.artist_id}.select {|id, array| array.length > 1}
    @artists.find_all {|artist| artists.has_key?(artist.id) }
  end

  def photographs_taken_by_artist_from(country)
    artists = @artists.select {|artist| artist.country == country}.map {|artist| artist.id}
    @photographs.select {|photograph| artists.include?(photograph.artist_id)}
  end


end
