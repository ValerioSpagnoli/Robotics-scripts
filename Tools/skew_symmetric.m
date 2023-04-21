function R = skew_symmetric(vector)
    x = vector(1);
    y = vector(2);
    z = vector(3);
    R = [ [0 -z y] ; [z 0 -x] ; [-y x 0] ];


