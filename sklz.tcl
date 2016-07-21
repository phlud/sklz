#                 STANDARD INTRO                \
 CLIENT: XiRCON Communicator                    \
 SCRIPT: TCL                                    \
 AUTHOR: Sn|p3r phire A.K.A. Infynite Phlud     \
 SCRIPT NAME: sklz.tcl                          \
 PLATFORM: WINBLOWS                             \
 STATUS: Final                                  \
#                                               \
  NOTE: I am not responsible for any misuse
# of certain features coded within this script.



###
#  Credit to:
#            Linear, Synopsis, Asymmetrick and Spi Cloak
#  Greetz to:
#            T8 and the rest of PSI for hangin' in there. Furthermore, thanx to my other covert
#            friends out there, you know who you are (~_^)
###


set hash(exists) 1
set ctcp 0
set idle 0
set away 0
set sb 0
set h ON
set t OFF
set filelimit 50
/nc  :
set aa "300"

/away
proc sver { arg } {
cd /
set fi [open ver w]
puts $fi "$arg"
close $fi
}
alias tcl { eval [join [args]];complete }
alias TOGG {
set string [args]
set f [string tolower $string]
if { [string match *h* $f] } { TOGG h }
if { [string match *t* $f] } { TOGG t }

complete
}
alias idle {
set aa [args]
complete

}
proc add2hash { nick uhost } {
global hash t
if { $t != "OFF" } {
set hash($nick) "$uhost [clock format [clock seconds]]"
}
}
proc TOGG { flag } {
global h t
switch $flag {
t { if { $t == "ON" } { set t OFF;echo "HASH TABLE is now off" } else { set t ON;echo "HASH TABLE is now ON" }}
h { if { $h == "ON" } { set h OFF;echo "Auto Hide MOTD is now off" } else { set h ON;echo "Auto Hide MOTD is now ON" }}
}
}
alias kb {
if { [info exists hash([string tolower [lindex [join [args]] 0])]] } {
/c +b [BanMask [lindex [split [lindex $hash([string tolower [lindex [join [args]] 0]]) 0] @] 0] [lindex [split [lindex $hash([string tolower [lindex [join [args]] 0]]) 0] @] 1]]
/k [lindex [join [args]] 0] KickBan
}
complete
}

on 379 {
global h
if { $h == "ON" } { complete }
}
on 378 {
global h
if { $h == "ON" } { complete }
}
on 377 {
global h
if { $h == "ON" } { complete }
}
alias rkey {
/c -k [lindex [mode [channel]] 1]
complete
}
on 376 {
global h
if { $h == "ON" } { complete }
}

alias me {
echo "\af5* [my_nick] [join [args]]"
if { [window_type] == "chat" } { /msg =[window_name] \001ACTION [join [args]]\001 }
if { [window_type] == "query" || [window_type] == "channel" } { /ctcp [window_name] ACTION [join [args]] }
complete
}


on 375 {
global h
if { $h == "ON" } { complete }
}
on 374 {
global h
if { $h == "ON" } { complete }
}
on 373 {
global h
if { $h == "ON" } { complete }
}
on 372 {
global h
if { $h == "ON" } { complete }
}

on 371 {
global h
if { $h == "ON" } { complete }
}

alias aver { 
cd /
set fi [open ver r]
gets $fi ver
close $fi
set fi [open ver w]
puts $fi "$ver + [join [args]]"
close $fi
complete
}

proc form { 1 2 } {
set erm "40"
set wut ""
for { set i 0 } { $i < [string length $1] } { incr i } {
set erm [expr $erm - 1]
}

for { set i 0 } { $i < $erm } { incr i } {
append wut "-"
}

return ${1}${wut}${2}
}

alias sv {
if { [join [args]] == "" } {
say "Im Skilled with: [gver]"
} else { /msg [join [args]] Im Skilled with: [gver] }
complete
}

proc gver { } {
cd /
set fi [open ver r]
gets $fi ver
close $fi
return $ver
}
alias ppl {
set ppl ""
regsub -all @ "[nicks [channel]]" "" ppl
foreach item $ppl { /hash $item }
complete
}
alias sb {
set sb 1
if { [args] != "" } { /mode #[args] +b } else { /mode [channel] +b }
complete
}
sver {XiRCON : Sk1llZ.tcl 3.8 FINAL by phlud... snipe or be sniped.}
alias SAVE {
global user h t
set fi [open /windows/sk1llz.sav w]
puts $fi "File created by [gver] at [clock format [clock seconds]]"
puts $fi "$h"
puts $fi "$t"
puts $fi "$aa"
puts $fi "$nc1"
puts $fi "$nc2"
close $fi
set fi [open /windows/sk1llz.usr w]
foreach item [array names user] {
puts $fi "$item $user($item)"
complete
}
close $fi
echo " "
echo "ALL DONE with /save"
echo " "
}


alias M { /msg [join [args]];complete }
alias WI { /whois [join [args]];echo "     ---- ( Whois : [join [args]] ) ----";complete }
alias WII { /raw whois [join [args]] [join [args]];echo "     ---- ( Whois : [join [args]] ) ----";complete }
on 318 { echo "     ----End Of WHOis----" }
alias J {
regsub -all # "[join [args]]" "" chanz
foreach item [split $chanz ,] { /raw join #$item}
complete
}
alias K {
set what [args]
set r [lrange $what 1 end]
if { $r == "" } { /raw kick [channel] $what :phlud's kick! } else { /raw kick [channel] [lindex $what 0] :$r }
complete
}

alias CD {
cd [join [args]]
echo "Working dir is now [pwd]"
complete
}
alias PWD { echo "Working dir is [pwd]";complete }

alias PLAY {
set fi [open [join [args]] "r"]
while { ![eof $fi] } {
gets $fi line
if { $line != "" } {
say " $line"
}
}
close $fi
complete
}
proc winver { } {
global tcl_platform
return "$tcl_platform(os)"
complete
}

alias VER { if { [join [args]] != "" } {
set who [join [args]]

/ctcp $who version
} else { /ctcp [channel] version }
complete
}
on ctcp {
add2hash [string tolower [nick]] [user]@[host]
 global ctcp
 if { [string match "*DCC SEND*" [string toupper [join [args]]]] && $ctcp == "0" } { echo "\acaDCC SEND [lindex [join [args]] 3] from [nick]([user]@[host])" }
 set what [string toupper [lindex [args] 1]]
 if { $what != "ACTION" && $what != "DCC" } {
        echo "CTCP [lindex [join [args]] 1] requested to \02[lindex [join [args]] 0]\02 by [nick]![user]@[host]"
 }
 set what [lindex [join [args]] 1]
 if { $ctcp == "0" } {
        if { [string toupper $what] == "VERSION" } {
                /raw notice [nick] ":VERSION [gver] : [winver]"
                complete
        }
        if { $what != "ACTION" } { set ctcp 5 }
 } else { echo "\002IGNORING CTCP ($ctcp)";complete }
 if { $what == "DCC" && $ctcp == "1" } { complete }
 if { $what == "DCC" && $ctcp == "0" } { set ctcp 5 }
 if { $what == "ACTION" } {
        if { [string match #* [lindex [join [args]] 0]] } { echo "\af5* [nick] [join [lrange [args] 2 end]]" channel [lindex [join [args]] 0] }
        if { ![string match #* [lindex [join [args]] 0]] } { echo "\af5* [nick] [join [lrange [args] 2 end]]" query [lindex [join [args]] 0] }
        complete
 }

}

alias INV {
set chan [channel]
if { [string match #* [lindex [join [args]] 0]] } { foreach list [nicks [lindex [join [args]] 0]] {
if { [string match +* $list] } { set list [lindex [split $list +] 1] }
regsub @ "$list" "" list
/raw invite $list $chan
}} else { /raw invite [lindex [join [args]] 0] $chan }
complete
}
echo "Type /info for help on how to append your scripts version reply"
echo "Type /help for help"
alias OP { /mode [channel] +oooo [join [args]];complete }
alias DOP { /mode [channel] -oooo [join [args]];complete }
alias C { /mode [channel] [join [args]];complete }
alias HELP {
if { [join [args]] == "" } {
echo "Commands are as follows:"
echo "\a1a HELP      INV    SLOAD    WI    J     GONE    CD   "
echo "\a1b PLAY      VER    INFO     OP    C     BACK    PWD  "
echo "\a1c NOTIFY    RUN    CHAT     LS    T     RELN    DOP  "
echo "\a1d COUNTRY   WII    RELM     SV    M     WALL    K    "
echo "\a1e SAVE      JI     AOP      NOP   SHIT  RSHIT   TOGG "
echo "\a1f LAG       NC     MASS     TCL   STATS RELCN   ALIAS"
echo "\a1a PPL       DNS    HASH     SB    IDLE               "
} else {
set cmd [string tolower [join [args]]]
switch $cmd {
idle { echo "\a1aSet your amount of seconds of idle b4 auto away hits." }
ppl   { echo "\a1aShows the user@host of everyone in the channel" }
dns { echo "\a1aDoes a DNS lookup on an ip or host" }
hash { echo "\a1aUse this to show the user@host of some one in your hash table" }
sb { echo "\a1aShows all current bans in your channel" }
alias { echo "\a1aUse this command to create tcl aliases... i.e. /alias hi /msg \[lindex \[join \[args\]\] 0\] hi there!" }
tcl { echo "\a1aThis will exicute a tcl command as if you were in a tcl script.  I.E. /tcl echo \"hi how are you\"" }
stats { echo "\a1bPrints out to you the channel status... try it, its neeto :)" }
relcn { echo "\a1cEchos to the channel your last ctcp reply" }
nc { echo "\a1dEffects the AutoNick Completion.  You would type /nc \"**\" \" ->\" and then when it would complete it would look like: **phlud -> text" }
mass { echo "\a1eMass mode commands... /mass o /mass d /mass k /mass lk /mass ok";echo "o = op, d = deop, lk = non op kick, ok = op kick, k = all kick" }
lag { echo "\a1fShows how lagged you are from your server" }
togg { echo "\a4aChanges a toggle.. usage /togg letter.  Current letters are t = toggle hash table and h = hide motd" }
shit { echo "\a4bAdds a user to shit list.... usage is /shit *!*user@*.host or *!*user@ip.*" }
rshit { echo "\a4dRemoves a user from the shit list.... usage is /rshit *!*user@*.host or *!*user@ip.*" }
aop { echo "\a4eAdds a user to ops list.... usage is /aop *!*user@*.host chan (if chan is ommited it adds them for all channels!) or *!*user@ip.*" }
nop { echo "\a4fRemoves a user from the ops list.... usage is /naop *!*user@*.host chan (if chan is ommited it adds them for all channels!) or *!*user@ip.*" }
m { echo "\a7aa shortcut for /msg" }
wi { echo "\a7ba shortcut for /whois" }
wii { echo "\a7ca shortcut for /whois nickname nickname (good for checking lag)" }
j { echo "\a1aa shortcut for /join... u can /j #chan or /j chan dont matter" }
cd { echo "\a1bchanges working dir for that script" }
pwd { echo "\a1cshows working directory for that script" }
play { echo "\a1dplays a file to a channel... must be in working dir... check /cd" }
ver { echo "\a1eVersions either topchannel or the nick/channel u specify" }
inv { echo "\a1fInvites either nick/#channel to your top channel" }
op { echo "\a1aops nicks... upto 4 at once" }
dop { echo "\a1bdeops nicks... upto 4 at once" }
help { echo "\a1cShows help... or help on a specified command" }
k { echo "\a1dkicks a nickname out of your current chan" }
c { echo "\a1echanges modes in your current chan" }
notify  { echo "Shows who is on your notify and if they are on irc or not" }
country { echo "\a1areturns what country is for what abbreviations... i.e. /country au This would echo AUSTRALIA" }
run     { echo "\a1bRuns a program... i think its not working well" }
chat    { echo "\a1cDCC CHAT's a person" }
relm    { echo "\a1dRelays last msg to a channel" }
reln    { echo "\a1eRelays last notice to a channel" }
sload    { echo "\a1fReplaces built in load command so you can use my functions like \[country\] and stuff like that" }
ls      { echo "\a1aDoes a full directory listing on current dir or does a listing on a wild card... /ls *.tcl or just /ls" }
sv      { echo "\a1b Shows to the top channel your current version reply" }
t       { echo "\a1cChanges topic in your current channel" }
wall    { echo "\a1dDoes a channel Wall Op" }
info    { echo "\a1eType it and you'll see!" }
ji      { echo "\a1fJoins last channel you were invited to" }
gone    { echo "\a1aSets you away and tells all your channels... /gone ill bbl" }
back    { echo "\a1bSets you back and tells all your channels... /back im back!" }
save    { echo "\a1cSaves all your settings that should be saved i.e. toggles, and user list" }
}
}
complete
}
alias INFO { echo "Make this the first line of your script...";echo "/aver myscript.tcl  ... replace myscript.tcl with what u want to append";complete }
alias NOTIFY {
if { [args] == "" } {
echo " "
echo " NICKS ON"
echo " $on"
} else {
set_user [add_user [join [args]]!*@*] notify Y
}
complete
}
set on ""
on notify {
set nlnick [join [nick]]
echo "[nick] [user]@[host] is ON IRC!"
append on "[join [nick]] "
}
on denotify {
regsub "[join [nick]] " "$on" "" on
echo "[nick] left irc!"
}
alias RUN { exec [join [lindex [args] 0]] [join [lrange [args] 1 end]] &;complete }
alias cn { global nlnick;/dcc chat $nlnick;complete }
alias IDL { global idle away;echo "$idle $away";complete }
on TIMER {
global idle away ctcp
if { $ctcp != "0" } { set ctcp [expr ${ctcp}-1] }
if { $away == "0" && $idle == "$aa" } {
foreach list [channels] { /ctcp $list ACTION is away - [expr $aa / 60] minute autoAWAY (SKiLLZ) }
foreach list [chats] { /msg =$list \001ACTION is away - [expr $aa / 60] minute autoAWAY (SKiLLZ) }
echo "You Now marked away - [expr $aa / 60] minute auto away"
/away [expr $aa / 60] minute autoAWAY (SKiLLZ)
global away
set away 1
} else {
if { $away == "0" && $idle < "$aa" } {
global idle
set idle [expr 1+$idle]
}
}
 if { [connected] == "1" && $lag != "1" } { /la }
}

set lag 0
alias lag { echo "Your lagtime is \002$ltime Seconds";complete }
alias la {
set lag1 [clock seconds]
/raw time
set lag 1
complete
}
on 391 {
if { $lag == "1" } {
  set lagtime [expr [clock seconds] - $lag1]
set ltime "$lagtime"
  complete
set lag 0
 }
}

alias CHAT { /dcc chat [join [args]];complete }

alias LS {
set args [join [args]]
set filz 0
set bytez 0
    if { $args == "" } \
    { 
set file "[glob -nocomplain *]"
set files [lsort $file]
global filelimit
set words 0
foreach item $files { incr words }
if { $words > $filelimit } { set files [lrange $files 0 [expr $filelimit -1]] }
                echo "Directory of [pwd]"
                foreach item $files { echo "[form $item ([commas [file size $item]])]";incr filz;set bytez [expr [file size $item] + $bytez] }
        }
        if { $args != "" } \
        {
set file "[glob -nocomplain $args]"
set files [lsort $file]
global filelimit
set words 0
foreach item $files { incr words }

if { $words > $filelimit } { set files [lrange $files 0 [expr $filelimit -1]] }

                echo "Directory of [pwd]"
                foreach item $files { echo "[form $item ([commas [file size $item]])]";incr filz;set bytez [expr [file size $item] + $bytez] }
        }
                echo "Total number of filez: \002[commas $filz]"
                echo "Total number of Bytes: \002[commas $bytez]"
complete
}
on PRIVMSG {
add2hash [string tolower [nick]] [user]@[host]
if { [lindex [args] 0] == "[my_nick]" } {
global mnick muh msg
set mnick [nick]
set muh [user]@[host]
set msg [lrange [args] 1 end]
}}



on NOTICE {
add2hash [string tolower [nick]] [user]@[host]
if { [lindex [args] 0] == "[my_nick]" } {
global nnick nuh not
set nnick [nick]
set nuh [user]@[host]
set not [lrange [args] 1 end]
}}
alias RELM { say "\[MSG\] (${mnick})$muh \[MSG\] [lindex $msg 0] [lrange $msg 1 end]";complete }
alias RELN { say "\[NOTICE\] (${nnick})$nuh \[NOTICE\] [lindex $not 0] [lrange $not 1 end]";complete }
alias WALL {
set ops ""
foreach list [nicks [channel] @*] { if { $list != "@[my_nick]" } { append ops "${list}," }}
set ops "$ops "
regsub ", " "$ops" "" ops
regsub -all "@" "$ops" "" ops
/raw notice $ops :\[WallOP:[channel]\] [join [args]]
echo "-> \[WallOP:[channel]\] [join [args]]"
complete
}

alias T { /topic [join [args]];complete }
proc country { ctr } {
set ctr [string tolower $ctr]
switch $ctr {
 af { return "AFGHANISTAN"                                              }
 al  { return "ALBANIA"                                                 }
 dz      { return "ALGERIA"                                             }
 as      { return "AMERICAN SAMOA"                                      }
 ad      { return "ANDORRA"                                             }
 ao      { return "ANGOLA"                                              }
 ai      { return "ANGUILLA"                                            }
 aq      { return "ANTARCTICA"                                          }
 ag      { return "ANTIGUA AND BARBUDA"                                 }
 ar      { return "ARGENTINA"                                           }
 am      { return "ARMENIA"                                             }
 aw      { return "ARUBA"                                               }
 au      { return "AUSTRALIA"                                           }
 az      { return "AZERBAIJAN"                                          }
 bs      { return "BAHAMAS"                                             }
 bh      { return "BAHRAIN"                                             }
 bd      { return "BANGLADESH"                                          }
 bb      { return "BARBADOS"                                            }
 by      { return "BELARUS"                                             }
 be      { return "BELGIUM"                                             }
 bz      { return "BELIZE"                                              }
 bj      { return "BENIN"                                               }
 bm       { return "BERMUDA"                                            }
 bt       { return "BHUTAN"                                             }
 bo       { return "BOLIVIA"                                            }
 ba       { return "BOSNIA"                                             }
 bw       { return "BOTSWANA"                                           }
 bv       { return "BOUVET ISLAND"                                      }
 br      { return "BRAZIL"                                              }
 io       { return "BRITISH INDIAN OCEAN TERRITORY"                     }
 bn       { return "BRUNEI DARUSSALAM"                                  }
 bg       { return "BULGARIA"                                           }
 bf       { return "BURKINA FASO"                                       }
 bi       { return "BURUNDI"                                            }
 kh      { return "CAMBODIA"                                            }
 cm      { return "CAMEROON"                                            }
 ca      { return "CANADA"                                              }
 cv      { return "CAP VERDE"                                           }
 ky      { return "CAYMAN ISLANDS"                                      }
 cf      { return "CENTRAL AFRICAN REPUBLIC"                            }
 td      { return "CHAD"                                                }
 cl      { return "CHILE"                                               }
 cn      { return "CHINA"                                               }
 cx      { return "CHRISTMAS ISLAND"                                    }
 cc      { return "COCOS \(KEELING\) ISLANDS"                           }
 co      { return "COLOMBIA"                                            }
 km      { return "COMOROS"                                             }
 cg      { return "CONGO"                                               }
 ck      { return "COOK ISLANDS"                                        }
 cr      { return "COSTA RICA"                                          }
 ci      { return "COTE D'IVOIRE"                                       }
 hr      { return "CROATIA"                                             }
 cu      { return "CUBA"                                                }
 cy      { return "CYPRUS"                                              }
 cs      { return "CZECHOSLOVAKIA"                                      }
 dk      { return "DENMARK"                                             }
 dj      { return "DJIBOUTI"                                            }
 dm      { return "DOMINICA"                                            }
 do      { return "DOMINICAN REPUBLIC"                                  }
 tp      { return "EAST TIMOR"                                          }
 ec      { return "ECUADOR"                                             }
 eg      { return "EGYPT"                                               }
 sv      { return "EL SALVADOR"                                         }
 gq      { return "EQUATORIAL GUINEA"                                   }
 ee      { return "ESTONIA"                                             }
 et      { return "ETHIOPIA"                                            }
 fk      { return "FALKLAND ISLANDS"                                    }
 fo      { return "FAROE ISLANDS"                                       }
 fj      { return "FIJI"                                                }
 fi      { return "FINLAND"                                             }
 fr      { return "FRANCE"                                              }
 gf      { return "FRENCH GUIANA"                                       }
 pf      { return "FRENCH POLYNESIA"                                    }
 tf      { return "FRENCH SOUTHERN TERRITORIES"                         }
 ga      { return "GABON"                                               }
 gm      { return "GAMBIA"                                              }
 ge      { return "GEORGIA"                                             }
 de      { return "GERMANY"                                             }
 gh      { return "GHANA"                                               }
 gi      { return "GIBRALTAR"                                           }
 gr      { return "GREECE"                                              }
 gl      { return "GREENLAND"                                           }
 gd      { return "GRENADA"                                             }
 gp      { return "GUADELOUPE"                                          }
 gu      { return "GUAM"                                                }
 gt      { return "GUATEMALA"                                           }
 gn      { return "GUINEA"                                              }
 gw      { return "GUINEA BISSAU"                                       }
 gy      { return "GYANA"                                               }
 ht      { return "HAITI"                                               }
 hm      { return "HEARD AND MC DONALD ISLANDS"                         }
 hn      { return "HONDURAS"                                            }
 hk      { return "HONG KONG"                                           }
 hu      { return "HUNGARY"                                             }
 is      { return "ICELAND"                                             }
 in      { return "INDIA"                                               }
 id      { return "INDONESIA"                                           }
 ir      { return "IRAN"                                                }
 iq      { return "IRAQ"                                                }
 ie      { return "IRELAND"                                             }
 il      { return "ISRAEL"                                              }
 it      { return "ITALY"                                               }
 jm      { return "JAMAICA"                                             }
 jp      { return "JAPAN"                                               }
 jo      { return "JORDAN"                                              }
 kz      { return "KAZAKHSTAN"                                          }
 ke      { return "KENYA"                                               }
 ki      { return "KIRIBATI"                                            }
 kp     { return "NORTH KOREA"                                          }
 kr      { return "SOUTH KOREA"                                         }
 kw      { return "KUWAIT"                                              }
 kg      { return "KYRGYZSTAN"                                          }
 la      { return "LAOS"                                                }
 lv      { return "LATVIA"                                              }
 lb      { return "LEBANON"                                             }
 ls      { return "LESOTHO"                                             }
 lr      { return "LIBERIA"                                             }
 ly      { return "LIBYAN ARAB JAMAHIRIYA"                              }
 li      { return "LIECHTENSTEIN"                                       }
 lt      { return "LITHUANIA"                                           }
 lu      { return "LUXEMBOURG"                                          }
 mo      { return "MACAU"                                               }
 mk      { return "MACEDONIA"                                           }
 mg      { return "MADAGASCAR"                                          }
 mw      { return "MALAWI"                                              }
 my      { return "MALAYSIA"                                            }
 mv      { return "MALDIVES"                                            }
 ml      { return "MALI"                                                }
 mt      { return "MALTA"                                               }
 mh      { return "MARSHALL ISLANDS"                                    }
 mq      { return "MARTINIQUE"                                          }
 mr      { return "MAURITANIA"                                              }
 mu      { return "MAURITIUS"                                              }
 mx      { return "MEXICO"                                                }
 fm      { return "MICRONESIA"                                           }
 md      { return "MOLDOVA"                                             }
 mc      { return "MONACO"                                             }
 mn      { return "MONGOLIA"                                          }
 ms      { return "MONTSERRAT"                                       }
 ma      { return "MOROCCO"                                         }
 mz      { return "MOZAMBIQUE"                                     }
 mm      { return "MYANMAR"                                       }
 na      { return "NAMIBIA"                                      }
 nr      { return "MAURU"                                       }
 np      { return "NEPAL"                                      }
 nl      { return "NETHERLANDS"                               }
 an      { return "NETHERLANDS ANTILLES"                     }
 nt      { return "NEUTRAL ZONE"                            }
 nc      { return "NEW CALEDONIA"                          }
 nz      { return "NEW ZEALAND"                           }
 ni      { return "NICARAGUA"                            }
 ne      { return "NIGER"                               }
 ng      { return "NIGERIA"                            }
 nu      { return "NIUE"                              }
 nf      { return "NORFOLK ISLAND"                   }
 mp      { return "NORTHERN MARIANA ISLANDS"        }
 no      { return "NORWAY"                         }
 om      { return "OMAN"                          }
 pk      { return "PAKISTAN"                     }
 pw      { return "PALAU"                       }
 pa      { return "PANAMA"                     }
 pg      { return "PAPUA NEW GUINEA"          }
 py      { return "PARAGUAY"                 }
 pe      { return "PERU"                    }
 ph      { return "PHILIPPINES"            }
 pn      { return "PITCAIRN"              }
 pl      { return "POLAND"               }
 pt      { return "PORTUGAL"            }
 pr      { return "PUERTO RICO"        }
 qa      { return "QATAR"             }
 re      { return "REUNION"                                                }
 ro      { return "ROMANIA"                                               }
 ru      { return "RUSSIAN FEDERATION"                                   }
 rw      { return "RWANDA"                                              }
 kn      { return "SAINT KITTS AND NEVIS"                              }
 lc      { return "SAINT LUCIA"                                       }
 vc      { return "SAINT VINCENT AND THE GRENADINES"                 }
 ws      { return "SAMOA"                                           }
 sm      { return "SAN MARINO"                                     }
 st      { return "SAO TOME AND PRINCIPE"                         }
 sa      { return "SAUDI ARABIA"                                 }
 sn      { return "SENEGAL"                                     }
 sc      { return "SEYCHELLES"                                 }
 sl      { return "SIERRA LEONE"                              }
 sg      { return "SINGAPORE"                               }
 si      { return "SLOVENIA"                                 }
 sb       { return "SOLOMON ISLANDS"                       }
 so      { return "SOMALIA"                               }
 za      { return "SOUTH AFRICA"                         }
 es       { return "SPAIN"                              }
 lk      { return "SRI LANKA"                          }
 sh      { return "ST. HELENA"                        }
 pm      { return "ST. PIERRE AND MIQUELON"          }
 sd      { return "SUDAN"                           }
 sr      { return "SURINAME"                       }
 sj      { return "SVALBARD AND JAN MAYEN ISLANDS"}
 sz      { return "SWAZILAND"}
 se      { return "SWEDEN"}
 ch      { return "SWITZERLAND, CANTONS OF HELVETIA, CONFEDERATION HELVETIQUE"}
 sy      { return "SYRIAN ARAB REPUBLIC, SYRIA"}
 tw      { return "TAIWAN"     }
 tj      { return "TAJIKISTAN"}
 tz      { return "TANZANIA" }
 th      { return "THAILAND"                                             }
 tg      { return "TOGO"                                                }
 tk      { return "TOKELAU"                                            }
 to      { return "TONGA"                                             }
 tt      { return "TRINIDAD AND TOBAGO"                              }
 tn      { return "TUNISIA"                                         }
 tr      { return "TURKEY"                                         }
 tm      { return "TURKMENISTAN"                                  }
 tc      { return "TURKS AND CAICOS ISLANDS"                     }
 tv      { return "TUVALU"                                      }
 ug      { return "UGANDA"                                     }
 ua      { return "UKRAINA"                                   }
 ae      { return "UNITED ARAB EMIRATES"                     }
 uk      { return "UNITED KINGDOM"                          }
 gb      { return "GREAT BRITAIN"                          }
 us      { return "UNITED STATES OF AMERICA"              }
 um      { return "UNITED STATES MINOR OUTLYING ISLANDS" }
 uy      { return "URUGUAY"                  }
 su      { return "USSR, SOVIET REPUBLIC"   }
 uz      { return "UZBEKISTAN"             }
 vu      { return "VANUATU"                                                 }
 va      { return "VATICAN CITY STATE"                                     }
 ve      { return "VENEZUELA"                                             }
 vn      { return "VIET NAM"                                             }
 vi      { return "VIRGIN ISLANDS \(US\)"                               }
 vg      { return "VIRGIN ISLANDS \(UK\)"                              }
 wf      { return "WALLIS AND FUTUNA ISLANDS"                        }
 eh      { return "WESTERN SAHARA"                                    }
 ye      { return "YEMEN"                                            }
 yu      { return "YUGOSLAVIA"                                      }
 zr      { return "ZAIRE"                                          }
 zm      { return "ZAMBIA"                                        }
 zw      { return "ZIMBABWE"                                     }
 com     { return "COMMERCIAL ORGANIZATION \(US\)"              }
 edu     { return "EDUCATIONAL INSTITUTION \(US\)"             }
 net     { return "NETWORKING ORGANIZATION \(US\)"            }
 mil     { return "MILITARY \(US\)"                          }
 org     { return "NON-PROFIT ORGANIZATION \(US\)"          }
 gov     { return "GOVERNMENT \(US\)"                      }
 kp      { return "DEMOCRATIC PEOPLE'S REPUBLIC OF KOREA" }
 la      { return { return "LAO PEOPLES' DEMOCRATIC REPUBLIC"               }
 sk      { return "SLOVAKIA"                                               }
 cz      { return "CZECH"                                                 }
 ato     { return "Nato field"                                           }
 rpa     { return "Old style Arpanet"                                   }
 int     { return "International"                                      }
 at      { return "Austria"                                           }
}
}
}
alias COUNTRY { echo "[country [join [args]]]";complete }
alias SLOAD { source [join [args]];echo "Loaded [join [args]]";complete }
alias PRIVMSG {
set idle 0
if { [lindex [args] 0] == "[channel]" && [string match *: [lindex [args] 1]] } {
set nick ""
set niq [lindex [split [lindex [args] 1] :] 0]

foreach nick [nicks [channel] @${niq}*] {
      set nick [string trimleft $nick "@+"]
}
foreach nick [nicks [channel] ${niq}*] {
      set nick [string trimleft $nick "@+"]
}
foreach nick [nicks [channel] +${niq}*] {
      set nick [string trimleft $nick "++"]
}


if { $nick != "" } {
/msg [channel] ${nc1}${nick}${nc2} [join [lrange [args] 2 end]]
complete
}
}
}
alias nc {
if { [lindex [join [args]] 1] == "" } { echo "FORMAT IS: /nc \"first part\" \"second part\"" } else {
set nc1 [lindex [join [args]] 0]
set nc2 [lindex [join [args]] 1]
}
complete
}


on 306 {
set away 1
}
on 305 {
set away 0
set idle 0
}
on INVITE {
global ichan
set ichan [lindex [join [args]] 1]
echo "[nick] invites you to join [lindex [join [args]] 1]"
echo "TYPE /JI to join it!"
}
alias JI { global ichan;/j $ichan;complete }
alias BACK {
foreach list [channels] {
if { [join [args]] != "" } {
echo "* [my_nick] is BACK - [join [args]]" channel $list
foreach list [channels] { 
/ctcp $list ACTION is BACK - [join [args]]
}
foreach list [chats] { /msg =$list \001ACTION is BACK - [join [args]] }
} else {
/ctcp $list ACTION is BACK - SKiLLZ
echo "* [my_nick] is BACK - SKiLLZ" channel $list
foreach list [chats] { /msg =$list \001ACTION is BACK - Love My SKiLLZ! }
}
}
/away
complete
}

alias GONE {
foreach list [chats] {
if { [join [args]] != "" } {
/msg =$list \001ACTION is GONE - [join [args]]
} else {
/msg =$list \001ACTION is GONE - SKiLLZ
}
}
foreach list [channels] {
if { [join [args]] != "" } {
/ctcp $list ACTION is GONE - [join [args]]
echo "* [my_nick] is GONE - [join [args]]" channel $list
} else {
/ctcp $list ACTION is GONE - SKiLLZ
echo "* [my_nick] is GONE - SKiLLZ" channel $list

}
}
if { [join [args]] == "" } { /away SKiLLZ } else { /away [join [args]] }
complete
}
proc dorehash { } {
if { [file exists /windows/sk1llz.sav] } {
global  h t aa nc1 nc2
set fi [open /windows/sk1llz.sav r]
gets $fi
gets $fi h
gets $fi t
gets $fi aa
gets $fi nc1
gets $fi nc2
close $fi
echo "LOADED SAVED SETTINGS"
}
}
if { [file exists /windows/sk1llz.usr] } {
global user
set fi [open /windows/sk1llz.usr r]
while { ![eof $fi] } {
set line [gets $fi]
set user([lindex $line 0]) "[lrange $line 1 end] "

}
close $fi
}

proc BanMask { user hst } {

set ctr [islet $hst]
if { $ctr == "0" } { set ctr "IP" } else { set ctr DNS }
set h [split $hst .]

if { $ctr == "IP" } {
set host *!*${user}@[lindex $h 0].[lindex $h 1].[lindex $h 2].*
} else {
set hs "[lrange $h 1 end]"
set host *!*${user}@*
foreach item $hs { append host .$item }
}
return "$host"
}


proc ex { host } {
global user
if { [info exists user($host)] } { return yes }
}
alias ulist {
foreach item [array get user] { echo $item }
complete
}

on JOIN {
add2hash [string tolower [nick]] [user]@[host]
global user
set blah [BanMask [user] [host]]
if { [info exists user($blah)] } {
 if { [lindex $user($blah) 0] == "1" && [string match *[args]+* [lrange $user($blah) 1 end]] } { /mode [args] +o [nick] }
 if { [lindex $user($blah) 0] == "2" && [string match "*[args]+*" [lrange $user($blah) 1 end]] } { /mode [args] +b $blah;/raw kick [args] [nick] :SK1LLZ KickBan list! }
 if { [lindex $user($blah) 0] == "1" && [lrange $user($blah) 1 end] == "all" } { /mode [args] +o [nick] }
 if { [lindex $user($blah) 0] == "2" && [lrange $user($blah) 1 end] == "all" } { /mode [args] +b $blah;/raw kick [args] [nick] :SK1LLZ KickBan list! }

 }
if { [nick] == [my_nick] } {
set whovar [expr $whovar + 1]
/who [args]
}
}
set whovar 0
on 352 {
if { $whovar != 0 } {
add2hash [string tolower [lindex [args] 5]] "[lindex [args] 2]@[lindex [args] 3]"
complete
return
}
}
on 315 {
if { $whovar != "0" } {
incr whovar -1
echo "\afcFinished Hashing [lindex [args] 1]" channel [lindex [args] 1]
complete
}
}
alias bk {
/c +b *!*$hash([string tolower [lindex [args] 0]])
/k [args]
complete
}
alias AOP {
global user
if { [lrange [args] 1 end] == "" } { set chans ALL } else { set chans [lrange [args] 1 end] }
if { $chans != "ALL" } {
set c ""
 foreach item $chans {
  append c "${item}+"
 }
set chans $c
}
set user([lindex [args] 0]) "1 [string tolower $chans]"
echo "Mask [args] added as an op!"
complete
}

alias NOP {
global user
unset user([args])
echo "Mask [args] Removed from op status!"
complete
}

alias SHIT {
global user
if { [lrange [args] 1 end] == "" } { set chans ALL } else { set chans [lrange [args] 1 end] }
if { $chans != "ALL" } {
set c ""
 foreach item $chans {
  append c "${item}+"
 }
set chans $c
}

set user([lindex [args] 0]) "2 [string tolower $chans]"
echo "Mask [args] added to shit status!"
complete
}
alias RSHIT {
global user
unset user([args])
echo "Mask [args] Removed from shit status!"
complete
}


dorehash
on chat_text {
 set what [string toupper [lindex [args] 0]]
 if { $what == "\001ACTION" } {
        echo "\af5* [nick] [join [lrange [args] 1 end]]" chat [nick]
        complete
 }
if { [args] == "." } { /msg =[nick] PONG! }
}

on 311 {
echo "*** nick:  [lindex [join [args]] 1]"
echo "*** real name:  [lrange [join [args]] 5 end]"
foreach list [split [lindex [join [args]] 3] .] { set ctr [country $list] }
if { $ctr == "" } { set ctr "IP Numeric" }
echo "*** uhost: [lindex [join [args]] 2]@[lindex [join [args]] 3] ($ctr)"
complete
}

on 317 {
set minutes [expr [lindex [args] 2] / 60]
set seconds [expr ${minutes} * 60]
set seconds [expr [lindex [args] 2]-$seconds]
echo "*** idle: $minutes mins $seconds secs"
complete
}

on 313 {
        echo "nick info: Is an IRC OP... just plain lame"
        complete
}
on 312 {
echo "*** server: [lrange [args] 2 end]"
complete
}
on 319 {
echo "*** channels: [join [lrange [args] 2 end]]"
complete
}

#### START MYNAME CODE
on 401 { echo "[lindex [args] 1] There is no such nick";complete }

on 467 { echo  "The Channel key is already set for [lindex [args] 1].";complete }
on 473 { echo " You Cannot join [lindex [args] 1]. Its Invite only";complete }
on 474 { echo  "You Cannot join [lindex [args] 1]. You are Banned!";complete }
on 481 { echo  "Sorry, Permission Denied- You're not an IRC operator";complete }
on 333 { echo  "Topic for [lindex [args] 1] set by [lindex [args] 2]";complete  }


#### END MYNAME CODE

alias mass {
set ops ""

if { [args] == "o" } {
/massop
}
if { [args] == "d" } {
/massdeop
}
if { [lindex [args] 0] == "lk" } {
foreach item [join [nicks [channel]]] {
if { ![string match @* $item] } { /k $item [lrange [join [args]] 1 end] }
}
}
if { [lindex [args] 0] == "ok" } {
foreach item [join [nicks [channel]]] {

if { [string match @* $item] } {
set ops "$item"
regsub -all "@" "$ops" "" ops
if { $ops != "[my_nick]" } {
/k $ops [lrange [join [args]] 1 end]
}
}}
}
if { [lindex [args] 0] == "k" } {
foreach item [join [nicks [channel]]] {

set ops "$item"
regsub -all "@" "$ops" "" ops
if { $ops != "[my_nick]" } {

/k $ops [lrange [join [args]] 1 end]
}}
}
complete
}
alias l { /part;complete }


alias um { /mode [my_nick] [args];complete }
on wallops { echo "\[IRC WALLOP\]: <[nick]![user]@[host]> [join [args]]";complete }
/mode [my_nick] +iw
on connect {
/la
/mode [my_nick] +iw
/away
set on ""
}
alias time {
echo "[clock format [clock seconds]]"
complete
}

alias MASSOP {
  set nicks [nicks [channel]]
  set args ""
  set count 0
  foreach nick $nicks {
    if { [string index $nick 0] != "@" } {
      lappend args [string trimleft $nick "@+"]
      incr count
    }
    if { $count == 4 } {
      /op [join $args]
      set args ""
      set count 0
    }
  }
  if { $count } { /op [join $args] }
complete
}

alias MASSDEOP {
  set nicks [nicks [channel]]
  set args ""
  set count 0
  foreach nick $nicks {
    if { [string index $nick 0] == "@" } {
      set nick [string trimleft $nick "@+"]
      if { $nick != [my_nick] } {
        lappend args $nick
        incr count
      }
    }
    if { $count == 4 } {
      /dop [join $args]
      set args ""
      set count 0
    }
  }
  if { $count } { /dop [join $args] }
complete
}
alias relcn {
global cnick cuh crep crep1
say "CTCP \002$crep\002 REPLY from ${cnick}!${cuh}: [join $crep1]"
complete
}
on ctcp_reply {
add2hash [string tolower [nick]] [user]@[host]
global cnick cuh crep crep1
set cnick [nick]
set cuh [user]@[host]
set crep [lindex [args] 1]
set crep1 [lrange [args] 2 end]
}

on 332 {
        echo "\002Topic For [lindex [args] 1]\02 [join [lrange [args] 2 end]]"
complete
}


on 471 {
        echo "Unable to join \002[lindex [args] 1]\002, Channel Is FULL(+l)"
}

on 473 {

        echo "Unable to join \002[lindex [args] 1]\002, Invite only(+i)" 
}

on 474 {

echo "Unable to join \002[lindex [args] 1]\002, BANNED(+b)" 
}

on 475 {

        echo "Unable to join \002[lindex [args] 1]\002, Need Correct Key(+k)"
}

alias stats {
if { [args] == "" } {
set ops 0
set nops 0
set vops 0
foreach item [nicks [channel] @*] { incr ops }
foreach item [nicks [channel] +*] { incr vops }
foreach item [nicks [channel]] { if { ![string match @* $item] } { incr nops }}
set total [expr $ops + $nops + $vops]
set opercent [lindex [split [expr ${ops}.0 / ${total}.0] .] 1]0
if { $opercent == "00" && [expr $ops / $total] == "1" } { set opercent 100 }
set npercent [lindex [split [expr ${nops}.0 / ${total}.0] .] 1]0
if { $npercent == "00" && [expr $nops / $total] == "1"  } { set npercent 100 }
set vpercent [lindex [split [expr ${vops}.0 / ${total}.0] .] 1]0
if { $vpercent == "00" && [expr $vops / $total] == "1"  } { set vpercent 100 }
echo "There are \002$ops OPs (\%[string index $opercent 0][string index $opercent 1])"
echo "There are \002$nops Non OPs (\%[string index $npercent 0][string index $npercent 1])"
echo "There are \002$vops +V's (\%[string index $vpercent 0][string index $vpercent 1])"
echo "There is a total of \002$total people on [channel]"
complete
} else {  }
}

menu status "&MOTD"             { /motd }
menu status ""
menu status "&List Channels"    { /list }
menu status ""
menu status "&Away"             { /gone }
menu status "&Back"             { /back }
menu status ""
menu status "&Who Am I?"        { /wi [my_nick] }
menu status "&Commands?" { /help }
menu status "&Help->&list1->HELP" { /help help }
menu status "&Help->&list1->INV" { /help inv }
menu status "&Help->&list1->SLOAD" { /help sload }
menu status "&Help->&list1->WI" { /help wi }
menu status &Help->&list1->J { /help j }
menu status &Help->&list1->GONE    { /help gone }
menu status &Help->&list1->CD  { /help cd }
menu status &Help->&list1->PLAY { /help play }
menu status &Help->&list1->VER    { /help ver }
menu status &Help->&list1->INFO     { /help info }
menu status &Help->&list2->OP    { /help op }
menu status &Help->&list2->C     { /help c }
menu status &Help->&list2->BACK    {/help back }
menu status &Help->&list2->PWD { /help pwd }
menu status &Help->&list2->NOTIFY    { /help notify }
menu status &Help->&list2->RUN    { /help run }
menu status &Help->&list2->CHAT     { /help chat }
menu status &Help->&list2->LS    { /help ls }
menu status &Help->&list2->T     { /help t }
menu status &Help->&list2->RELN    { /help reln }
menu status &Help->&list2->DOP { /help dop }
menu status &Help->&list2->COUNTRY   { /help country }
menu status &Help->&list3->WII    { /help wii }
menu status &Help->&list3->RELM     { /help relm }
menu status &Help->&list3->SV    { /help sv }
menu status &Help->&list3->M     { /help m }
menu status &Help->&list3->WALL    { /help wall }
menu status &Help->&list3->K   { /help k }
menu status &Help->&list3->SAVE      { /help save }
menu status &Help->&list3->JI     { /help ji }
menu status &Help->&list3->AOP      { /help aop }
menu status &Help->&list3->NOP   { /help nop }
menu status &Help->&list3->SHIT  { /help shit }
menu status &Help->&list3->RSHIT   { /help rshit }
menu status &Help->&list3->TOGG { /help togg }
menu status &Help->&list3->LAG       { /help lag }
menu status &Help->&list3->NC     { /help nc }
menu status &Help->&list3->MASS     { /help mass }
menu status &Help->&list3->TCL   { /help tcl }
menu status &Help->&list3->STATS { /help stats }
menu status &Help->&list3->RELCN       { /help relcn }


on 368 { if { $sb == "1" } {
echo "\002End of Banlist" }
set sb 0
}
proc commas { num } {
 set result ""
 set len [string length $num]
 for { set i 0 } { $i < $len } { incr i +1 } {
   if { ($i > 0) && ($i % 3 == 0) } { set result ",$result" }
   set result [string index $num [expr $len - $i - 1]]$result
 }
 return $result
}
proc islet { a } \
{
set arg [string tolower $a]
if { [regexp {[a-z]} $arg] } { return 1 } else { return 0 }
}
on 367 {
if { $sb == "1" } {
echo "\002[lindex [args] 1]:\002 [lindex [args] 2]"
complete
}
}
on 302 {
set q [lindex [split [args] =] 0]
set q [lindex [split $q " "] 1]
set qq [lindex [split [args] =] 1]
set qqq ""
 set len [string length $qq]
 for { set i 1 } { $i < $len } { incr i +1 } {
 set qqq $qqq[string index $qq $i]
 }
  

add2hash [string tolower $q] $qqq
complete
}
alias dns {
    set host [lindex [args] 0]
    lookup $host
    echo "*** Attempting to resolve $host"
complete
}

on lookup {
    set request [lindex [args] 0]
    set result  [lindex [args] 1]
    if { [string length $result] } {
        echo "*** Resolved $request to $result"
    } else {
        echo "[color error]*** ERROR: Could not resolve $request"
    }
}

alias hash {
if { [info exists hash([string tolower [join [args]]])] } { echo "\002[join [args]] [lindex $hash([string tolower [join [args]]]) 0]"} else { echo "\002No such nick in hash" }
complete
}
alias seen {
if { [info exists hash([string tolower [join [args]]])] } { echo "\002Last saw [join [args]] at: [lrange $hash([string tolower [join [args]]]) 1 end]"} else { echo "\002No such nick in hash" }
complete
}
on part {
add2hash [string tolower [nick]] [user]@[host]
}
alias alias {
set cmd [lindex [join [args]] 0]
alias $cmd [lrange [join [args]] 1 end]
complete
}
alias colors {
  echo "[color Default]Default"
  echo "[color Public]Public"
  echo "[color Private]Private"
  echo "[color Notice]Notice"
  echo "[color CTCP]CTCP"
  echo "[color Change]Change"
  echo "[color Join]Join"
  echo "[color Part]Part"
  echo "[color Quit]Quit"
  echo "[color Highlight]Highlight"
  echo "[color Attribute]Attribute"
  echo "[color Error]Error"
  echo "[color Nick]Nick"
  echo "[color Channel]Channel"
  echo "[color Mode]Mode"
  echo "[color Command]Command"
  echo "[color Users]Users"
  echo "\aF0*\aF1 *\aF2 *\aF3 *\aF4 *\aF5 *\aF6 *\aF7 *\aF8 *\aF9 *\aFA *\aFB *\aFC *\aFD *\aFE *\aFF *"
  echo "\a00*\a01 *\a02 *\a03 *\a04 *\a05 *\a06 *\a07 *\a08 *\a09 *\a0A *\a0B *\a0C *\a0D *\a0E *\a0F *"
complete
}
on kick {
if { [lindex [args] 1] == [my_nick] } { echo "You were kicked from [lindex [args] 0] by [nick]: [lrange [args] 2 end]" Status Status
}
}

### HotKeys
#
hotkey control+n { /notify;complete }
hotkey alt+c { /cn;complete }
hotkey control+x { /quit Sk1llZ;complete }
hotkey alt+f4    { /quit Sk1llZ R0X yur momz }
hotkey control+i { /ji;complete }
hotkey tab {
set words ""
set word ""
set line [input get_text]
if { $line != "" } {
foreach item $line { set niq $item }
if { [string match #* [channel]] } {
set words -2
foreach it $line { incr words }
if { $words == "-1" } { set word "" } else {
set word [lrange $line 0 $words]
}
set nick ""
foreach nick [nicks [channel] @${niq}*] {
      set nick [string trimleft $nick "@+"]
}
foreach nick [nicks [channel] ${niq}*] {
      set nick [string trimleft $nick "@+"]
}
foreach nick [nicks [channel] +${niq}*] {
      set nick [string trimleft $nick "++"]
}

if { $nick != "" } {
if { [string index $word 0] == " " } { echo test }
if { $word == "" } { input set_text "$nick " } else { input set_text "$word $nick " }
input set_sel_start 1000000
complete
}
}
}
}
/server [server]
echo "Now Re-Connecting (A MUST for getting the NOTIFY right :-( )"

#
### End of HotKeys

proc isop { nick channel } {
set nicks "[nicks $channel] "
if { [string match "*@${nick} *" $nicks] } { return 1 } else { return 0 }
}

on mode+b {
if { [isop [my_nick] [lindex [args] 0]] } {
regsub -all @ "[nicks [lindex [args] 0]]" "" ppl
foreach item $ppl {
if { [string match [lindex [args] 1] ${item}![lindex $hash([string tolower $item]) 0]] } {
if { $item == [my_nick] } { /mode [lindex [args] 0] -b [lindex [args] 1] } else { /k $item You are banned on [lindex [server] 0] }
}
}
}
}

echo " "
echo " "
echo " "
echo " "

echo "3,0   . . .. .      . .. . .      . .. . .      . .. . .      . ... .."
echo "3,0   :      :      :      :      :      :      :      :      :      :"
echo "3,0   :      :      :      :      :      :      :      .      :      :"
echo "4,1,ssSSP¾ý4\$\$\$\$   3,0 :      :      :      :      :      :   4,1 \$\$\$\$4ý¾PSSss,"
echo "4,1\$\$\$\$\$   \$\$\$\$\$   3,0 .      :      :      .      :      :   4,1 \$\$\$\$\$   \$\$\$\$\$"
echo "4,1\$\$\$\$\$   \$\$\$\$\$ \$\$\$\$   Sss, essS\$. ,ssS3,0 :  4,1    ,ssS  3,0 : 4,1   \$\$Pý'   \$\$\$\$\$"
echo "4,1`ý¾4\$sniperz, \$\$\$\$eed\$Pý'  \$\$\$\$: \$\$\$\$ :      \$\$\$\$  3,0 : 4,1   ,skillz!\$P¾ý'"
echo "4,1\$\$byy   \$\$\$\$\$ \$\$\$\$  `\$\$s,  \$\$\$\$: \$\$\$\$ . Sss, \$\$\$\$   Sss, \$\$\$\$\$   ,yb\$\$"
echo "4,1\$\$\$\$\$   \$\$\$\$\$ \$\$\$\$   \$\$\$\$  \$\$\$\$. \$\$\$\$ : \$\$\$\$ \$\$\$\$   \$\$\$\$ \$\$\$\$\$   \$\$\$\$\$"
echo "4,1\$\$\$\$\$   \$\$\$\$\$ \$\$\$\$   \$\$\$\$  \$\$\$\$: \$\$\$\$ : \$\$\$\$ \$\$\$\$   \$\$\$\$ \$\$\$\$\$   \$\$\$\$\$"
echo "4,1\$\$\$\$\$e%#\$P¾ý' \$\$\$\$   \$Pý' e\$\$\$\$e `ý4\$#%e\$\$\$\$ `ý4\$#%e\$\$\$\$ `ý¾4\$#%e\$\$\$\$\$"
echo "3,0   :      :      :      :      :      :      :      :      :      :"
echo "3,0   :      : . ...:      :. .. .:      :.. . .:      :.. .. :      :"
echo ""
echo "3,0Written by 1,8Phlud"
echo "Type /colors to see something Linear made... phear"
echo "\a1fType /info for addon script info"
echo "Type /whatsnew to see whats new in this latest version"
echo "\a13This \a1fis \a1ba \a1cPSI \a1dProduction"
after 1000 /la

alias whatsnew {
echo "this is whats new from version 3.6 (might be a little more then documented sorry)"
echo "added a few small bug fixes"
echo "now kicks people if they match a new ban"
echo "now if your banned sk1llz auto unbans you"
echo "added newest function, isop <nick> <channel>"
echo "removed isconnected function"
complete
}
