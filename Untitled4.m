a = input("Enter matrix A (in form [a ; b; c]) : ");
b = input("Enter matrix B (in the form [a; b; c]) : ");

fprintf(" Ax = B \n\n");

[fprintf("%d ", a(1,:)), fprintf("\t"), fprintf("   x"), fprintf("\t    "), fprintf("%d", b(1)), fprintf("\n")];
[fprintf("%d ", a(2,:)), fprintf("\t"), fprintf(" * y"), fprintf("\t=   "), fprintf("%d", b(2)), fprintf("\n")];
[fprintf("%d ", a(3,:)), fprintf("\t"), fprintf("   z"), fprintf("\t    "), fprintf("%d", b(3)), fprintf("\n")];

fprintf("\nLet LU = A\n");
[fprintf("  1    0    0\t    u(11) u(12) u(13)\t "), fprintf("\t    "), fprintf("%d  ", a(1,:)), fprintf("\n")];
[fprintf("l(21)  1    0\t *   0    u(22) u(23)\t "), fprintf("\t=   "), fprintf("%d  ", a(2,:)), fprintf("\n")];
[fprintf("l(31) l(32) 1\t     0      0   u(33)\t "), fprintf("\t    "), fprintf("%d  ", a(3,:)), fprintf("\n\n\n")];


[fprintf("  u(11)           u(12)                    u(13)            "), fprintf("\t    "), fprintf("%d  ", a(1,:)), fprintf("\n")];
[fprintf("u(11)l(21)   l(21)u(12)+u(22)         l(21)u(13)+u(23)      "), fprintf("\t=   "), fprintf("%d  ", a(2,:)), fprintf("\n")];
[fprintf("u(11)l(31) l(31)u(12)+l(32)u(22) l(31)u(13)+l(32)u(23)+u(33)"), fprintf("\t    "), fprintf("%d  ", a(3,:)), fprintf("\n")];

u11 = a(1,1);
u12 = a(1,2);
u13 = a(1,3);
l21 = roots([u11 -a(2,1)]);
l31 = roots([u11 -a(3,1)]);
u22 = roots([1 l21*u12-a(2,2)]);
u23 = roots([1 l21*u13-a(2,3)]);
l32 = roots([u22 l31*u12-a(3,2)]);
u33 = roots([1 l31*u13+l32*u23-a(3,3)]);

fprintf("\n\nu(11) = %s\n",rats(u11))
fprintf("l(21) = %s\n",rats(l21))
fprintf("l(31) = %s\n",rats(l31))
fprintf("u(12) = %s\n",rats(u12))
fprintf("u(22) = %s\n",rats(u22))     
fprintf("l(32) = %s\n",rats(l32))     
fprintf("u(13) = %s\n",rats(u13))
fprintf("u(23) = %s\n",rats(u23))
fprintf("u(33) = %s\n\n",rats(u33))

[fprintf("       1             0            0 \t%s%s%s\t ", rats(u11), rats(u12), rats(u13)), fprintf("   x \t  "), fprintf("%d  ", a(1,:)), fprintf("\n")];
[fprintf("%s      1             0   *   \t 0      %s%s\t ", rats(l21), rats(u22), rats(u23)), fprintf(" * y \t= "), fprintf("%d  ", a(2,:)), fprintf("\n")];
[fprintf("%s%s      1       \t 0            0      %s\t   ", rats(l31), rats(l32), rats(u33)), fprintf("     z \t  "), fprintf("%d  ", a(3,:)), fprintf("\n")];

fprintf("\nLet LY = B   ,   LUX = B   ,   UX = Y\n");

[fprintf("       1            0            0      \t "), fprintf("   y1 \t  "), fprintf("%s  ", rats(b(1))), fprintf("\n")];
[fprintf("%s      1             0      \t ", rats(l21)), fprintf(" * y2 \t= "), fprintf("%s  ", rats(b(2))), fprintf("\n")];
[fprintf("%s%s      1       \t ", rats(l31), rats(l32)), fprintf("   y3 \t  "), fprintf("%s  ", rats(b(3))), fprintf("\n\n\n")];

final_l = [1 0 0; l21 1 0; l31 l32 1];

final_y = final_l\b;

[fprintf("y1   %s\n", rats(final_y(1))), fprintf("y2 = %s\n", rats(final_y(2))), fprintf("y3   %s\n\n", rats(final_y(3)))];

fprintf("\nUX = Y\n\n");

[fprintf("%s%s%s\t ", rats(u11), rats(u12), rats(u13)), fprintf("   x1 \t  "), fprintf("%s  ", rats(final_y(1))), fprintf("\n")];
[fprintf("      0      %s%s\t ", rats(u22), rats(u23)), fprintf(" * x2 \t= "), fprintf("%s  ", rats(final_y(2))), fprintf("\n")];
[fprintf("      0            0      %s\t ", rats(u33)), fprintf("   x3 \t  "), fprintf("%s  ", rats(final_y(3))), fprintf("\n\n\n")];

final_u = [u11 u12 u13; 0 u22 u23; 0 0 u33];

final_x = final_u\final_y;

[fprintf("x1   %s\n", rats(final_x(1))), fprintf("x2 = %s\n", rats(final_x(2))), fprintf("x3   %s\n\n", rats(final_x(3)))];

final_ans = a\b;
[fprintf("x   %s\n", rats(final_ans(1))), fprintf("y = %s\n", rats(final_ans(2))), fprintf("z   %s\n\n", rats(final_ans(3)))];

