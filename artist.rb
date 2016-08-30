class Artist
  attr_accessor :name, :id, :tracks
  def initialize(name,tracks)
    @name = name
    name_split = name.split
    name_split.class
    @id = ''
    for variable in name_split
      @id = @id + variable[0]
    end
    @tracks = tracks
  end

  # Add a Track to the track list
  def addTrack(track)
    @tracks.push(track)
  end

  # Prints the name of all the Tracks in the track list
  def printTracks
    for variable in @tracks do
      puts variable.name
    end
  end

  # Prints the name and count of all the Tracks in the track list
  def printTracksAndCount
    for variable in @tracks do
      puts "#{variable.name} which has been played #{variable.count} times"
    end
  end

  # Calls the method that increments the count of a Track from the Track class
  def playTrack(track_name)
    for variable in @tracks do
      if variable.name == track_name
        variable.incrementCount
      end
    end
  end
end
