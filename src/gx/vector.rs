#[derive(Debug)]
pub struct Vector {
    pub x: i16,
    pub y: i16,
}

/// equality
impl PartialEq for Vector {
    fn eq(&self, other: &Self) -> bool {
        self.x == other.x && self.y == other.y
    }
}

impl Vector {
    /// vector subtraction,
    pub fn sub(&self, _b: &Vector) -> Vector {
        Vector { x: 0, y: 0 }
    }

    /// dot product,
    pub fn dot(&self, _b: &Vector) -> Vector {
        Vector { x: 0, y: 0 }
    }

    /// cross product,
    pub fn cross(&self, _b: &Vector) -> Vector {
        Vector { x: 0, y: 0 }
    }

    /// scalar multiplication, and
    pub fn mul(&self, _b: &Vector) -> Vector {
        Vector { x: 0, y: 0 }
    }

    /// scalar division
    pub fn div(&self, _b: &Vector) -> Vector {
        Vector { x: 0, y: 0 }
    }
}

/// vector addition,
impl std::ops::Add for Vector {
    type Output = Self;

    fn add(self, rhs: Self) -> Self::Output {
        Vector {
            x: self.x + rhs.x,
            y: self.y + rhs.y,
        }
    }
}

#[cfg(test)]
mod test {
    use super::Vector;
    #[test]
    fn add() {
        let a = Vector { x: 1, y: 2 };
        let b = Vector { x: 3, y: 4 };
        assert_eq!(a + b, Vector { x: 4, y: 6 });
    }
}
