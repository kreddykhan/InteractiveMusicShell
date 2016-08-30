# InteractiveMusicShell
This program creates an Interactive Music Shell

The program consists of three classes: MakeMusicMagic, Artist and Track

The Track class holds simply a name and a count. It has a method that allows the count to be incremented. Since Tracks are always stored in Artist playlists they don't have an associated Artist name. This also allows them to be associated with multiple Artists.

The Artist method has a name, an id which is determined based on the name and an Array of Track objects.

The MakeMusicMagic is responsible for loading the music library and manipulating it.
MakeMusicMagic can present information about the library, as well as information about an individual artist or track.
It can also add an Artist or Track to the library.
In order to do this it creates an Artist object with an empty track list.  Tracks that are added, are added by creating Track objects and adding them to the Artist track lists.

The music library is stored using a PStore file. This file is loaded every time MakeMusicMagic is created. Whenever an Artist or Track is added the PStore file is saved. This way if there is an error the updated Artist and Track information is saved to the disk. It is also saved when the user exits the program which is how play counts are saved.
