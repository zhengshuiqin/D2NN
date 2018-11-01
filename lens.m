function Fai = lens(var,focus_length)

Fai = 2*pi*var.ft./var.c.*(var.x.^2+var.y.^2)/2/(focus_length);
