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

/// vector addition,
impl std::ops::Add for Vector {
    type Output = Self;

    fn add(self, rhs: Self) -> Self::Output {
        Self {
            x: self.x + rhs.x,
            y: self.y + rhs.y,
        }
    }
}

#[test]
fn test_add() {
    let a = Vector { x: 1, y: 2 };
    let b = Vector { x: 3, y: 4 };
    assert_eq!(a + b, Vector { x: 4, y: 6 });
}

impl std::ops::Mul<i16> for Vector {
    type Output = Self;

    fn mul(self, rhs: i16) -> Self::Output {
        Self {
            x: self.x * rhs,
            y: self.y * rhs,
        }
    }
}

#[test]
fn test_muli() {
    let a = Vector { x: 1, y: 2 };
    assert_eq!(a * 2i16, Vector { x: 2, y: 4 });
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
