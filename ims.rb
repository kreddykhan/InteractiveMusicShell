# Require pstore for database storage and the artist, track and makeMusicMagic class
require 'pstore'
require_relative 'artist.rb'
require_relative 'track.rb'
require_relative 'makeMusicMagic.rb'

myMusic = MakeMusicMagic.new
myMusic.runMusic
