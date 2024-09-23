pub struct Vector {
    pub x: i16,
    pub y: i16,
}

impl Vector {
    /// vector addition,
    pub fn add(&self, b: &Vector) -> Vector {
        Vector { x: 0, y: 0 }
    }

    /// vector subtraction,
    pub fn sub(&self, b: &Vector) -> Vector {
        Vector { x: 0, y: 0 }
    }

    /// dot product,
    pub fn dot(&self, b: &Vector) -> Vector {
        Vector { x: 0, y: 0 }
    }

    /// cross product,
    pub fn cross(&self, b: &Vector) -> Vector {
        Vector { x: 0, y: 0 }
    }

    /// scalar multiplication, and
    pub fn mul(&self, b: &Vector) -> Vector {
        Vector { x: 0, y: 0 }
    }

    /// scalar division
    pub fn div(&self, b: &Vector) -> Vector {
        Vector { x: 0, y: 0 }
    }
}

#[cfg(test)]
mod test {
    use super::Vector;
    #[test]
    fn test_add() {
        let a = Vector { x: 1, y: 2 };
        let b = Vector { x: 3, y: 4 };
        assert_eq!(a + b, Vector { x: 4, y: 5 });
    }
}
