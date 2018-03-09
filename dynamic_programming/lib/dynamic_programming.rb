class DynamicProgramming

  def initialize
    @cache_blair = {}

    @cache_fh = {}
    @cache_sfh = {}
    @cache_ks = {}
    @cache_maze = {}
  end

  def blair_nums(n)
    # kth blair # = k-1 + k-2 + (k-1)st odd number
    # blair(3) = 1 + 2 + 3 = 6
    return 1 if n == 1
    return 2 if n == 2
    return @cache_blair[n] if @cache_blair[n]

    @cache_blair[1] = 1
    @cache_blair[2] = 2

    i = 3
    until i > n
      @cache_blair[i] = @cache_blair[i-2] + @cache_blair[i-1] + 2*i - 3

      i+=1
    end

    return @cache_blair[n] if @cache_blair[n]
  end

  def frog_hops_bottom_up(n)
    return [[1]] if n == 1
    return [[1,1], [2]] if n == 2
    return [[3], [2,1], [1,2], [1,1,1]] if n == 3

    return frog_cache_builder(n)
  end

  def frog_cache_builder(n)
    @cache_fh[1] = [[1]]
    @cache_fh[2] = [[1,1], [2]]
    @cache_fh[3] = [[3], [2,1], [1,2], [1,1,1]]

    cache_idx = 4
    while cache_idx <= n
      result = []
      i = 1
      while i <= cache_idx/2
        result = result.dup.concat(combine(@cache_fh[i], @cache_fh[cache_idx-i])).uniq
        i+=1
      end

      @cache_fh[cache_idx] = result.uniq
      cache_idx+=1
    end

    @cache_fh[n]
  end

  def combine(arr1, arr2)
    result = []

    arr1.each do |hops1|
      arr2.each do |hops2|
        result << hops1.dup.concat(hops2)
        result << hops2.dup.concat(hops1)
      end
    end

    result.uniq
  end

  def frog_hops_top_down(n)
  end

  def frog_hops_top_down_helper(n)
  end

  def super_frog_hops(n, k)
  end

  def knapsack(weights, values, capacity)
  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)
  end

  def maze_solver(maze, start_pos, end_pos)
  end
end
