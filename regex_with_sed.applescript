set theStr to "\"Blog Submitter\" <solercio.4545454654@gmail.com>"
-- set thecommandstring to "echo \"" & filename & "\"|sed \"s/[0-9]\\{10\\}/*good*(&)/\"" as string
set thecommandstring to quoted form of "echo sed \"[a-z0-9.!#$%&'+\\-/=?^_{}|~]+@[a-z0-9.]+\" " & quoted form of theStr as string
set sedResult to do shell script thecommandstring
-- set isgood to sedResult starts with "*good*"