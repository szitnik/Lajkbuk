package si.zitnik.likebook.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import si.zitnik.likebook.domain.Campaign;
import si.zitnik.likebook.domain.Customer;

/**
 * Created with IntelliJ IDEA.
 * User: slavkoz
 * Date: 5/8/13
 * Time: 8:09 PM
 * To change this template use Campaign | Settings | Campaign Templates.
 */
public interface CustomerRepository extends JpaRepository<Customer, Long> {
    Customer findById(Long id);
}

