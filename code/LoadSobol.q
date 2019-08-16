/ bind C++ Sobol sequence generator into q function using ffi
\l /home/deanna/q/ffi.q
sobolSeq16384N:.ffi.bind[(`$"/home/deanna/q/l64/sobol"),`SobolSeq16384N;"iiF";"f"]
sobol:{{a:y#0f;sobolSeq16384N(x;y;a);a[y-1]}[;y]each 1+til x}