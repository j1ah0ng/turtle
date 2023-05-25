use std::vec::Vec;

/// A single cell needs to knowon which sides it has walls.
#[derive(Copy, Clone, Hash)]
pub struct Cell {
    walls: [bool; 4],
}

impl Cell {
    pub fn new() -> Cell {
        Cell {
            walls: [true, true, true, true],
        }
    }
    pub fn north(&mut self) -> &mut bool {
        &mut self.walls[0]
    }
    pub fn east(&mut self) -> &mut bool {
        &mut self.walls[1]
    }
    pub fn south(&mut self) -> &mut bool {
        &mut self.walls[2]
    }
    pub fn west(&mut self) -> &mut bool {
        &mut self.walls[3]
    }
}

pub struct Maze {
    /// A wall is an ordered pair of the absolute index of the cells it borders.
    walls: Vec<(u32, u32)>,

    /// The absolute index of a cell is given by (16 * row + col).
    cells: [ [ Cell; 16 ]; 16],
}

impl Maze {
    pub fn new() -> Maze {
        // Create a new maze.
        let mut m = Maze {
            walls: vec!(),
            cells: [ [Cell::new(); 16]; 16 ],
        };

        // Initialize the walls so every border is a wall.
        for row in 0..15 {
            for col in 0..16 {
                // Intra-row borders
                let this_cell = Self::idx_from_r_c(row, col);
                let next_cell = Self::idx_from_r_c(row, col + 1);
                m.walls.push(Self::tuple_from_idx(this_cell, next_cell));

                // Intra-col borders if we are not on the last row
                if row != 15 {
                    let lower_cell = Self::idx_from_r_c(row, col + 1);
                    m.walls.push(Self::tuple_from_idx(this_cell, lower_cell));
                }
            }
        }
        m
    }

    fn idx_from_r_c(r: u32, c: u32) -> u32 {
        16 * r + c
    }
    fn tuple_from_idx(i1: u32, i2: u32) -> (u32, u32) {
        if i1 < i2 {
            (i1, i2)
        } else {
            (i2, i1)
        }
    }
}
