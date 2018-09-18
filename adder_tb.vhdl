-- a testbench has no ports
entity adder_tb is
  end adder_tb;

  architecture behav of adder_tb is
    -- declaration of the component that will be instantiated
    component adder
      port (
        i0, i1, ci : in bit;
        s, co : out bit);
    end component;

    -- specify which entity is bound with the component
    for adder_0: adder use entity work.adder;
    signal i0, i1, ci, s, co : bit;
  begin
    -- component instantiation
    adder_0: adder port map (
      i0 => i0, i1 => i1, ci => ci, s => s, co => co);

    process
      type test_t is record
        -- inputs
        i0, i1, ci : bit;
        -- expected outputs
        s, co : bit;
      end record;
      type tests_t is array (natural range <>) of test_t;
      constant tests : tests_t :=
        (('0', '0', '0', '0', '0'),
         ('0', '0', '1', '1', '0'),
         ('0', '1', '0', '1', '0'),
         ('0', '1', '1', '0', '1'),
         ('1', '0', '0', '1', '0'),
         ('1', '0', '1', '0', '1'),
         ('1', '1', '0', '0', '1'),
         ('1', '1', '1', '1', '1'));
    begin
      for i in tests'range loop
        -- set inputs
        i0 <= tests(i).i0;
        i1 <= tests(i).i1;
        ci <= tests(i).ci;
        -- wait for results
        wait for 1 ns;
        -- check outputs
        assert s = tests(i).s
          report "bad sum value" severity error;
        assert co = tests(i).co
          report "bad carry out value" severity error;
      end loop;
      assert false report "Done" severity note;
        -- wait forever to complete simulation
      wait;
    end process;
  end behav;
