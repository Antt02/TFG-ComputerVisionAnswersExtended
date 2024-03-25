// components/Header.js
import styles from './Header.module.css'; // Importa los estilos CSS

const Header = () => {
  return (
    <header className={styles.header}>
      <div className={styles.content}>
        <h1 className={styles.title}>HandScript Automator</h1>
        <h2 className={styles.subtitle}>Automatize your handwritten answers</h2>
      </div>
    </header>
  );
};

export default Header;
