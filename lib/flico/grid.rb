# frozen_string_literal: true

require 'flico/cell'

module Flico
  class Grid
    GRID	= [[0, 1, 1, 2], [3, 4, 5, 6], [7, 8, 8, 9]].freeze
    CANV_WIDTH 	= 1750
    CANV_HEIGHT = 1250

    def canv_width
      CANV_WIDTH
    end

    def canv_height
      CANV_HEIGHT
    end

    def columns
      GRID.max_by(&:size).size
    end

    def column_cells
      GRID.transpose
    end

    def rows
      GRID.size
    end

    def row_cells
      GRID
    end

    def cell_width(name)
      cell_size(CANV_WIDTH, columns, size_multiplier(row_cells, name))
    end

    def cell_height(name)
      cell_size(CANV_HEIGHT, rows, size_multiplier(column_cells, name))
    end

    def crop_rectangle(cell_name, image_width, image_height)
      x = 0
      y = 0
      image = Cell.new(image_width, image_height)
      cell = cell_rectangle(cell_name)

      if image.aspect_ratio >= cell.aspect_ratio
        final_width = image_width - (image.width - (image.height * cell.aspect_ratio))
        final_height = image.height
      else
        final_width = image.width
        final_height = image.height - (image.height - (image.width / cell.aspect_ratio))
      end

      Cell.new(x, y, final_width, final_height)
    end

    def resize_rectangle(cell_name, image_width, image_height)
      Cell.new(image_width, image_height)
      cell_rectangle(cell_name)
    end

    def cell_rectangle(name)
      column = column_cells.find_index do |row|
        row.include? name
      end
      row = row_cells.find_index { |row| row.include? name }
      Cell.new(column * (CANV_WIDTH / columns), row * (CANV_HEIGHT / rows), cell_width(name), cell_height(name))
    end

    private

    def size_multiplier(table, name)
      table.map { |row| row.count(name) }.max
    end

    def cell_size(total, divisions, multiplier)
      multiplier.zero? ? 0 : ((total / divisions) * multiplier)
    end
  end
end
