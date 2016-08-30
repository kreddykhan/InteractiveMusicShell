require 'pstore'

class MakeMusicMagic
  attr_accessor :data
  def initialize
    puts "Welcome to the Interactive Music Shell!"
    # Search for the music_library.pstore. Load it if it exists or create it if it doesn't
    @music_library = PStore.new('music_library.pstore')
    # Load the data (which is a hash map). If it's nil create a new Hash
    @data = @music_library.transaction{@music_library[:data]}
    if @data.class == NilClass
      @data = Hash.new
    end
    puts "Start typing commands or type 'help' to get started"
    print "> "
    @current_playlist = []
    # runMusic
  end

  def runMusic
    while user_input_words = $stdin.gets.chomp.split
      # By splitting the user_input it is possible to easily detemine what the user wants
      # and to grab the relevant values
      case user_input_words[0]
      when "exit"
        # When you exit be sure to update the library data before quiting
        @music_library.transaction do
          @music_library[:data] = @data
        end
        puts "That's all folks"
        break
      when "help"
        helpful
      when "info"
        inform(user_input_words)
      when "add"
        additive(user_input_words)
      when "play"
        playMusic(user_input_words)
      when "count"
        artist_id = user_input_words[user_input_words.size - 1]
        puts @data[:"#{artist_id}"].tracks.size
      when "list"
        artist_id = user_input_words[user_input_words.size - 1]
        @data[:"#{artist_id}"].printTracksAndCount
      else
        puts "I don't recognize that command. Type 'help' to see a list of commands"
      end
      print "> "
    end
  end

  def helpful
    help_lines = "Use the following commands to use your Interactive Music Shell:
    exit: save your music library and eit the program
    info: display a summary of your library
    info track trackname: display info about the track trackname
    info artist *artist_id*: display info about the specific artist
    add artist *artistname*: add the new artist to the library
    add track *trackname* by *artist_id*: add a new track
    play track *trackname* by *artist_id*: play the track trackname by artist_id
    count tracks by *artist_id*: displays a count of a specific artist
    list tracks by *artist_id*: list tracks by a specific artist"
    puts help_lines
  end

  def inform(user_input_words)
    case user_input_words[1]
    when nil
      puts "Here is your current library:"
      @data.each do |key, value|
        puts "Artist name: " + value.name
        puts "Artist id: " + value.id
        puts "Discography:"
        value.printTracks
        puts
      end
      puts "The current playlist is:"
      puts @current_playlist
    when "artist"
      # Determine the artist id
      artist_id = user_input_words[2]
      # If that id exists in the data
      if @data.has_key?(:"#{artist_id}")
        # Print the artist name and relevant information
        puts "Artist name: " + @data[:"#{artist_id}"].name
        puts "Artist id: " + @data[:"#{artist_id}"].id
        puts "Discography:"
        @data[:"#{artist_id}"].printTracksAndCount
      else
        puts artist_id + " isn't in library"
      end
    when "track"
      # Determine the track name
      track_name = user_input_words[2..user_input_words.size].join(" ")
      # For each key value pair in the database
      @data.each do |key, value|
        # for each track in the value (which is an Artist object)
        value.tracks.each do |track|
          # If the track name matches one of the tracks print the relevant information
          if track.name == track_name
            puts "Song Title: " + track.name
            puts "Artist: " + @data[:"#{key}"].name
            puts "Play count: #{track.count}"
            # manipulating this break on and off determines whether or not to search for only one instance
            break
          end
        end
      end
    else
      puts "I don't recognize that command. Type 'help' to see a list of commands"
    end
  end

  def additive(user_input_words)
    case user_input_words[1]
    when "artist"
      # Determine the artist name
      artist_name = user_input_words[2..user_input_words.size]
      artist_name = artist_name.join(" ")
      # Create a new Artist object
      current_artist =  Artist.new(artist_name,[])
      # Add the Artist to the database using the artist id
      @data[:"#{current_artist.id}"] = current_artist
      # Save the updated database
      @music_library.transaction do
        @music_library[:data] = @data
      end
    when "track"
      # Determine the trackname and the artist it is by
      track_name = user_input_words[2..user_input_words.size-3].join(" ")
      artist_id = user_input_words[user_input_words.size - 1]
      # Create a new Track object
      current_track = Track.new(track_name)
      # Check if the artist id exists in the library
      if @data.key?(:"#{artist_id}")
        # Add the current track to the Artist's track list
        @data[:"#{artist_id}"].addTrack(current_track)
        # Save the database
        @music_library.transaction do
          @music_library[:data] = @data
        end
      else
        puts "That artist is not yet in your library. Add the artist first."
      end
    else
      puts "I don't recognize that command. Type 'help' to see a list of commands"
    end
  end

  def playMusic(user_input_words)
    track_name = user_input_words[2..user_input_words.size-3].join(" ")
    artist_id = user_input_words[user_input_words.size-1]
    time = Time.new
    @current_playlist.push("#{track_name} was played at #{time}")
    @data[:"#{artist_id}"].playTrack(track_name)
  end
end
