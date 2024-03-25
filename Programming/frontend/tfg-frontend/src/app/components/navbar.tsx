import styles from './navbar.module.css';

const Navbar = () => {
    return (
      <nav className={styles.navbar}>
        <div className={styles.logo}>
          <img src="/ruta/de/la/imagen-del-logo.png" alt="Logo de la página" />
        </div>
        <div className={styles.centerItems}>
          <a href="#">About us</a>
          <a href="#">Our services</a>
          <a href="#">Contact us</a>
        </div>
        <div className={styles.rightItems}>
          <button>Login</button>
        </div>
      </nav>
    );
  };
  
  export default Navbar;