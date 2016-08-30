require 'minitest/autorun'
require './makeMusicMagic'
require './artist'
require './track'

describe "artists" do
  it "has a name, id and track list" do
    artist1 = Artist.new("Michael Jackson",[])
    artist2 = Artist.new("Coldplay",["Everglow"])
    assert_instance_of Artist, artist1
    assert_instance_of Artist, artist2
  end
end

describe "track" do
  it "has a name and a count" do
    track1 = Track.new("Everglow")
    assert_instance_of Track, track1
  end
end

describe "MakeMusicMagic" do
  it "is an instance of MakeMusicMagic" do
    myMusic = MakeMusicMagic.new
    assert_instance_of MakeMusicMagic, myMusic
  end
end

describe "add artist" do
  it "add an artist to the database" do
    myMusic = MakeMusicMagic.new
    myMusic.additive(["add","artist","Grimes"])
    if myMusic.data.key?(:"G")
      assert(true)
    else
      assert(false)
    end
  end
end

describe "add track" do
  it "add a track to the database" do
    myMusic = MakeMusicMagic.new
    myMusic.additive(["add","artist","Grimes"])
    myMusic.additive(["add","track","Scream","by","G"])
    myMusic.data[:"G"].tracks[0].name == "Scream"
  end
end
