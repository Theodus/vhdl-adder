entity adder is
  port (
    i0, i1, ci : in bit;
    s, co : out bit);
end adder;

architecture rtl of adder is
begin
  -- This full-adder architecture contains two concurrent assignments.
  s <= i0 xor i1 xor ci;
  co <= (i0 and i1) or (i0 and ci) or (i1 and ci);
end rtl;
